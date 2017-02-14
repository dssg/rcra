from drain import data, aggregate, util
from drain.data import ToHDF, FromSQL, index_as_series, Merge
from drain.step import Step
from drain.aggregation import AggregationJoin
from epa.output import aggregations, investigations
from epa.output.handlers import HANDLER_BOOLEANS

import os
from datetime import date
import logging
import pandas as pd
import numpy as np

class EpaData(Step):
    """ Joins the datasets together. Combines output.facility_years0101, output.handlers, output.br
    and output.facilities. Then it joins onto this the aggregations.  
    The run method outputs a dict with X as a numpy array and aux.   
    """
    def __init__(self, month, day, year_min=2000, year_max=2017,
            outcome_years=1, investigations_drop_lists=True):

        Step.__init__(self, month=month, day=day, 
                year_min=year_min, year_max=year_max, 
                outcome_years=outcome_years, 
                investigations_drop_lists=investigations_drop_lists)

        if outcome_years != 1:
            raise NotImplementedError(
                'Currently only outcome_years=1 is implemented')
	
	# Grabs the dates over which the modelling is run. If modelling year starts on 1st Jan then day=01 and month=01
        dates = tuple(date(year, month, day) for year in range(year_min, year_max+1))
        
	# Grabs all the aggregation steps in a dict format
        self.aggregators = aggregations.all_dict(dates)

        sql_vars = { 'doy' : '%02d%02d' % (month, day), 
                'date_min' : date(year_min, month, day), 
                'date_max' : date(year_max, month, day) }

	# Extracts facility years from output.facility_years0101 by using the step FromSQL. Subs in sql_vars into query. 
	# FromSQL is a wrapper for pd.read_sql in pandas
        facility_years = FromSQL(query="""
select * from output.facility_years{doy} 
where date between '{date_min}' and '{date_max}'""".format(**sql_vars),
                parse_dates=['date'], tables=['output.facility_years{doy}'.format(**sql_vars)])
        facility_years.target = True
        
	# Extracts handler data (ie: whether it is sqg or lqg and other handler specific data)
	# store reference handlers because we need those columns
        self.handlers = FromSQL(table='output.handlers', parse_dates=['receive_date'])
        self.handlers.target = True

	# Merge is a wrapper for df.merge in pandas 
	# Left joins facility_years with the entire output.facilities postgres table using rcra_id
	# output.facilities contains state, region, NAICS code
        facilities = FromSQL(table='output.facilities',
            parse_dates=['min_start_date', 'max_start_date',
                         'min_receive_date', 'max_receive_date'])
        facilities.target = True

        handler_names = FromSQL('select rcra_id, dedupe_id as entity_id from dedupe.unique_map', tables=['dedupe.unique_map'])
        handler_names.target=True

        X = Merge(on='rcra_id', how='left', inputs=[facility_years, facilities, handler_names])	
        # Merges with handler (sqg/lqg status etc.)
        X = Merge(on=['rcra_id', 'handler_id'], how='left',
                inputs = [X, self.handlers])

	# Imports br data
        br = FromSQL(table='output.br')
        br.target=True
	
	# combines (but does not join) X, br and aggregation data
        self.inputs = [X, br] + self.aggregators.values()

    def run(self, X, br, *args):
        logging.info('Adding features')
        X['handler_received'] = X.handler_id.notnull()
        X['handler_age'] = (X.date - X.receive_date)/util.day

        # aux is facility_years join facilities join handlers
        # minus the final index (rcra_id, date) plus naics_codes
        # (plus last_investigation, which is added below)
        aux_columns = X.columns.difference(['rcra_id', 'date'])\
                .difference(HANDLER_BOOLEANS)\
                .union(['naics_codes'])

        # drop facility and facility_years except a few columns
        # evaluation is included for the HDF index, then dropped by the hdf reader
        x_drop_columns = aux_columns.union(['receive_date', 'handler_id'])\
                .difference(['evaluation', 'handler_received', 'handler_age', 'br', 'region', 'state'])
	
	# Joins on the br data, 2013 is hard coded as the latest year available!
        logging.info('Joining BR')
        year = X.date.dt.year
        X['br_reporting_year'] = (year - 3 + (year % 2)).apply(lambda y: max(y, 2013))
        data.prefix_columns(br, 'br_', ignore=['rcra_id'])
        X = X.merge(br, on=['rcra_id', 'br_reporting_year'], how='left')
        X.drop(['br_date', 'br_reporting_year'], axis=1, inplace=True)

        # Adds the aggregations by joining them on
        logging.info('Joining spatiotemporal aggregations')
        for name,aggregator in self.aggregators.iteritems():
            logging.info('Joining %s' % name)
            X = aggregator.join(X)
	
	# Splits aux from the X data
        logging.info('Splitting aux and X')
        X['rcra_id'] = X.rcra_id.astype(str) # use ascii for HDF index
        X.set_index(['rcra_id', 'date'], inplace=True)
        aux = X[aux_columns]

        X.drop(x_drop_columns, axis=1, inplace=True)

        aux['last_investigation_days'] = X['investigations_facility_all_start_date_days_min']
        aux['last_investigation_date'] = (index_as_series(aux, 'date') - 
                aux.last_investigation_days*util.day)
        aux['manifest_monthly_3y_approx_qty_max'] = X.manifest_monthly_facility_3y_approx_qty_max
        aux['manifest_monthly_all_approx_qty_max'] = X.manifest_monthly_facility_all_approx_qty_max

        aux['last_manifest_gen_sign_days'] = X['manifest_facility_all_gen_sign_date_min']
        aux['last_manifest_gen_sign_date'] = (index_as_series(aux, 'date') - 
                aux.last_manifest_gen_sign_days*util.day)
        
	# Drops NA in NAICS codes and theb binarizes them
        logging.info('Expanding naics codes')
        X['naics1'] = aux.naics_codes.dropna().apply(lambda n: set(i[0] for i in n) )
        X['naics2'] = aux.naics_codes.dropna().apply(lambda n: set(i[0:2] for i in n) )
        data.binarize_sets(X, ['naics1'])
        data.binarize_sets(X, ['naics2'])

        #_investigations_lists(X, drop=self.investigations_drop_lists) 
	# Binarizes state and region
        data.binarize(X, ['region', 'state'])
	
	# Converts to np array so that it can be fed into models
        X = X.astype(np.float32, copy=False)
        # make sure active_today is a bool
        aux['active_today'] = aux.active_today.astype(np.bool)
        return {'X': X, 'aux':aux}

def _investigations_lists(df, drop):
    columns = df.columns
    list_columns = data.select_regexes(columns,
            ['investigations_.*_%s' % c for c in investigations.list_columns])
    if not drop:
        for c in list_columns:
            data.expand_counts(df, c)

        for c in df.columns.difference(columns):
            count_column = aggregate.get_spacetime_prefix(c) + 'count'
            df[c[:-5]+'prop'] = df[c] / df[count_column]
    else:
        df.drop(list_columns, axis=1, inplace=True)
