from drain import data, aggregate, util
from drain.data import ToHDF, FromSQL, index_as_series
from drain.step import Step
from epa.output import aggregations, investigations

import os
from datetime import date
import logging
import pandas as pd
import numpy as np

class EpaData(Step):
    EXCLUDE = {'formal_enforcement_epa', 'formal_enforcement_state', 
            'formal_enforcement', 'min_formal_enforcement_date_epa', 
            'min_formal_enforcement_date_state', 
            'min_formal_enforcement_date', 'receive_date', 
            'violation_epa', 'violation_state', 'violation', 
            'evaluation_epa', 'evaluation_state',
            #'violation_future_epa', 'violation_future_state', 
            #'violation_future',
            'active_today', 'naics_codes', 'max_start_date', 
            'handler_id', 'min_start_date', 'max_receive_date', 
            'min_receive_date'}

    AUX = ['evaluation', 'region', 'state', 'handler_received', 
            'handler_age']

    def __init__(self, month, day, year_min=2007, year_max=2016, 
            outcome_years=1, investigations_drop_lists=True, **kwargs):

        Step.__init__(self, month=month, day=day, 
                year_min=year_min, year_max=year_max, 
                outcome_years=outcome_years, 
                investigations_drop_lists=investigations_drop_lists, 
                **kwargs)

        if outcome_years != 1:
            raise NotImplementedError(
                'Currently only outcome_years=1 is implemented')

        dates = [date(year, month, day) for year in range(year_min, year_max+1)]
        self.aggregators = { 
                'investigations': aggregations.investigations(dates),
                'handlers': aggregations.handlers(dates),
                'icis': aggregations.icis(dates),
                'rmp' : aggregations.rmp(dates)}

        sql_vars = { 'doy' : '%02d%02d' % (month, day), 
                'date_min' : date(year_min, month, day), 
                'date_max' : date(year_max, month, day) }

        self.inputs = [FromSQL(query="""
select * from output.facility_years{doy} 
where date between '{date_min}' and '{date_max}'""".format(**sql_vars), 
                parse_dates=['date'], target=True)] + self.aggregators.values()
        self.inputs_mapping = ['X']
        self.put_args = {'X':dict(format='t', 
            data_columns=['date', 'evaluation', 'region'])}

    def run(self, X, *args, **kwargs):
        logging.info('Joining spatiotemporal aggregations')
        for k in self.aggregators.keys():
            X = self.aggregators[k].join(X)
        
        logging.info('Expanding naics codes')
        X['naics1'] = X.naics_codes.dropna().apply(lambda n: set(i[0] for i in n) )
        X['naics2'] = X.naics_codes.dropna().apply(lambda n: set(i[0:2] for i in n) )
        data.binarize_set(X, 'naics1')
        data.binarize_set(X, 'naics2')

        X['rcra_id'] = X.rcra_id.apply(lambda s: s.encode('ascii'))
        X.set_index(['rcra_id', 'date'], inplace=True)

        aux = X[self.AUX + list(self.EXCLUDE)].copy()

        _investigations_lists(X, drop=self.investigations_drop_lists) 
        X = data.select_features(X, exclude=self.EXCLUDE)

        # keep region for hdf index
        data.binarize(X, category_classes={'region'}, drop=False)
        data.binarize(X, category_classes={'state'})

        X = X.astype(np.float32, copy=False)
        
        #ToHDF.run(self, X=X,aux=aux)
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
