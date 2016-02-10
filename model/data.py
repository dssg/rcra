from drain.util import index_as_series
from drain import data, aggregate, util
from drain.step import Step

from epa.output.investigations_aggregated import InvestigationsAggregator
from epa.output.handlers_aggregated import HandlersAggregator

import os
from datetime import date,datetime
import logging
import pandas as pd
import numpy as np

class EpaData(Step):
    psql_dir = os.environ['PSQL_DIR'] if 'PSQL_DIR' in os.environ else ''
    data_dir = os.environ['DATA_DIR'] if 'DATA_DIR' in os.environ else ''
    DEPENDENCIES = [os.path.join(psql_dir, d) for d in ['output/investigations', 'output/handlers', 'output/region_states' ]]

    EXCLUDE = {'formal_enforcement_epa', 'formal_enforcement_state', 'formal_enforcement',
               'min_formal_enforcement_date_epa', 'min_formal_enforcement_date_state', 'min_formal_enforcement_date',
               'receive_date', 'violation_epa', 'violation_state', 'violation',
               'evaluation_epa', 'evaluation_state', # 'evaluation',
               'violation_future_epa', 'violation_future_state', 'violation_future',
               'active_today', 'naics_codes', 'max_start_date', 'handler_id',
               'min_start_date', 'max_receive_date', 'min_receive_date'}

    AUX = ['rcra_id', 'date',  
             'formal_enforcement', 'formal_enforcement_epa', 'formal_enforcement_state',
             'min_formal_enforcement_date', 'min_formal_enforcement_date_epa', 'min_formal_enforcement_date_state',
             'active_today', 'region', 'state', 'naics_codes',
             'evaluation', 'evaluation_epa', 'evaluation_state',
             'violation_state', 'violation_epa', 'violation',
             #'violation_future', 'violation_future_epa', 'violation_future_state',
             'handler_received', 'handler_age']

    def __init__(self, month, day, year_min=2004, year_max=2014, outcome_years=1, investigations_drop_lists=True, **kwargs):
        Step.__init__(self, month=month, day=day, year_min=year_min, year_max=year_max, 
                      outcome_years=outcome_years, investigations_drop_lists=investigations_drop_lists, **kwargs)

        if outcome_years != 1:
            raise NotImplementedError('Currently only outcome_years=1 is implemented')

        ag_dir = os.path.join(self.data_dir, 'output/aggregated/')
        self.aggregators = {
            'investigations': InvestigationsAggregator(ag_dir),
            'handlers': HandlersAggregator(ag_dir)
        }
        self.inputs = [FromSQL('output.facility_years%02d%02d' % (month, day), parse_dates=['date'], target=True)] + aggregators.values()
        self.inputs_mapping = ['X']

    def run(self, X, *args, **kwargs):
        X = aggregators['investigations'].join(X)
        X = aggregators['handlers'].join(X)
        
        logging.info('Expanding naics codes')
        X['naics1'] = df.naics_codes.dropna().apply(lambda n: set(i[0] for i in n) )
        X['naics2'] = df.naics_codes.dropna().apply(lambda n: set(i[0:2] for i in n) )
        data.binarize_set(X, 'naics1')
        data.binarize_set(X, 'naics2')

        X['rcra_id'] = X.rcra_id.apply(lambda s: s.encode('ascii'))
        X.set_index(['rcra_id', 'date'], inplace=True)

        aux = X[self.AUX].copy()

        _investigations_lists(df, drop=self.investigations_drop_lists) 
        df = data.select_features(df, exclude=self.EXCLUDE)

        # keep region for hdf index
        data.binarize(X, category_classes={'region'}, drop=False)
        data.binarize(X, category_classes={'state'})

        X = X.astype(np.float32, copy=False)
        
        return {'X': df, 'aux':aux}

class EpaHDFStore(Step):
    def __init__(self, **kwargs):
        Step.__init__(self, **kwargs)

    def run(self, X, aux, **kwargs):
        store = pd.HDFStore(os.path.join(self.get_dump_dirname(), 'result.h5'))

        logging.info('Writing X %s' % str(X.shape))
        store.put('X', X, mode='w', format='t', data_columns=['date', 'evaluation', 'region'])

        logging.info('Writing aux %s' % str(aux.shape))
        store.put('aux', aux, mode='w')

        return {'store' : store}

    def dump(self):
        return

    def load(self):
        self.set_result({'store': pd.HDFStore(os.path.join(self.get_dump_dirname(), 'result.h5'))})

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
