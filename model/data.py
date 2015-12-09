from drain.data import ModelData, censor_column
from drain.util import index_as_series
from drain import data, aggregate, util

from epa.output.investigations_aggregated import InvestigationsAggregator

import os
from datetime import date,datetime
import logging
import pandas as pd
import numpy as np

class EpaData(ModelData):
    psql_dir = os.environ['PSQL_DIR'] if 'PSQL_DIR' in os.environ else ''
    data_dir = os.environ['DATA_DIR'] if 'DATA_DIR' in os.environ else ''
    DEPENDENCIES = [os.path.join(psql_dir, d) for d in ['output/investigations', 'output/handlers', 'output/region_states' ]]

    EXCLUDE = {'formal_enforcement_epa', 'formal_enforcement_state', 'formal_enforcement',
               'min_formal_enforcement_date_epa', 'min_formal_enforcement_date_state', 'min_formal_enforcement_date',
               'receive_date', 'violation_epa', 'violation_state', 'violation',
               'evaluation_epa', 'evaluation_state', 'evaluation',
               'violation_future_epa', 'violation_future_state', 'violation_future',
               'active_today', 'naics_codes', 'max_start_date', 'handler_id',
               'min_start_date', 'max_receive_date', 'min_receive_date'}

    DATES = {'date', 'min_formal_enforcement_date_epa', 'min_formal_enforcement_date_state', 
               'min_formal_enforcement_date', 'receive_date'}

    def __init__(self, min_year, max_year, month=1, day=1, outcome_years=1, min_predict_year=None, max_predict_year=None):
        if outcome_years != 1:
            raise NotImplementedError('Currently only outcome_years=1 is implemented')

        self.min_year = min_year
        self.max_year = max_year
        self.month = month
        self.day = day
        self.outcome_years = outcome_years
        self.min_predict_year = min_predict_year if min_predict_year is not None else min_year
        self.max_predict_year = max_predict_year if max_predict_year is not None else max_year

    def read(self, directory=None):
        if directory is not None:
            dfs = []
            dfs.extend( (pd.read_hdf(os.path.join(directory, 'df%sTrue.h5' % year))
                    for year in xrange(self.min_year, self.max_year+1) ))
            dfs.extend( (pd.read_hdf(os.path.join(directory, 'df%sFalse.h5' % year))
                    for year in xrange(self.min_predict_year, self.max_predict_year+1) ))
            self.df = pd.concat(dfs)
            return

        engine = util.create_engine()

        sql_vars = {
            'doy' : '%02d%02d' % (self.month, self.day),
            'min_date' : date(self.min_year, self.month, self.day),
            'max_date' : date(self.max_year, self.month, self.day),
            'min_predict_date' : date(self.min_predict_year, self.month, self.day),
            'max_predict_date' : date(self.max_predict_year, self.month, self.day),
        }

        sql = """
            select * from output.facility_years{doy} where date between '{min_date}' and '{max_date}' and 
            (evaluation or date between '{min_predict_date}' and '{max_predict_date}')
        """
        logging.info('Reading investigations')
        df = pd.read_sql(sql.format(**sql_vars), engine, parse_dates=['date'])

        logging.info('Reading investigations_aggregated')
        investigations_aggregator = InvestigationsAggregator(os.path.join(self.data_dir, 'output/aggregated/'))
        agg = investigations_aggregator.read(left=df)
        
        logging.info('Joining investigations_aggregated')
        df = df.merge(agg, left_on=['rcra_id', 'date'], right_index=True, how='left')

        logging.info('Expanding naics codes')
        df['naics1'] = df.naics_codes.dropna().apply(lambda n: set(i[0] for i in n) )
        df['naics2'] = df.naics_codes.dropna().apply(lambda n: set(i[0:2] for i in n) )
        data.binarize_set(df, 'naics1')
        data.binarize_set(df, 'naics2')

        self.df = df

    def write(self, directory):
        for year in xrange(self.min_year, self.max_year+1):
            for evaluation in [True, False]:
                df = self.df[(self.df.date.apply(lambda d: d.year) == year) & (self.df.evaluation == evaluation)]
                filename = os.path.join(directory, 'df%s%s.h5' % (year, evaluation))
                logging.info('Writing %s: %s' % (filename, df.shape))
                df.to_hdf(filename, 'df', mode='w')

    def transform(self, year, train_years,
            outcome='violation_epa', # when None training_outcome=testin_outcome
            region = 0,
            directory=None,
            training_outcome = None,
            # the max handler age to be included (in addition to active_today) in all testing and evaluation training
            handler_max_age = 365, 
            investigations_expand_counts=False,
            exclude=[], include=[],
            impute=True, normalize=True):

        if not (self.min_predict_year <= year <= self.max_predict_year):
            raise ValueError('year {1} not between min_predict_year {2} and max_predict_year {3}'.format(
                    year, self.min_predict_year, self.max_predict_year))

        testing_outcome = outcome
        if training_outcome is None:
            training_outcome = outcome

        # set params for efficient read()
        self.min_year = year-train_years
        self.max_year = year
        self.max_predict_year = year
        self.min_predict_year = self.min_year if training_outcome.startswith('evaluation') else year
         
        logging.info('Reading data')
        self.read(directory)

        logging.info('Splitting train and test sets')
        if year - train_years < self.min_year:
            raise ValueError('Invalid argument: year - train_years < min_year')

        self.today = date(year, self.month, self.day)
        exclude = set(exclude)
        include = set(include)

        df = self.df
        if region != 0:
            df.drop(df.index[~(df.region == region)], inplace=True)

        min_date = date(year-train_years, self.month, self.day)
        max_date = date(year, self.month, self.day)
        df = df.loc[df.index[(df.date >= min_date) & (df.date <= max_date)]]

        df.set_index(['rcra_id', 'date'], inplace=True)

        train = index_as_series(df, 'date') < self.today
        test = ~train & ((df.handler_age < handler_max_age) | df.active_today)

        if training_outcome.startswith('violation'):
	    # training set for violation(|_epa|_state) is evaluation(|_epa|_state)
            train = train & df[training_outcome.replace('violation', 'evaluation')]
        else:
            # training set for evaluation is (active today or evaluated or handler under 1 year old)
            train = train & (df.active_today | df.evaluation | (df.handler_age < handler_max_age))
        # note test set is independent of outcome

        df,train,test = data.train_test_subset(df, train, test)
        self.cv = (train, test)

        # censor formal enforcements based on corresponding min date
        for c in ['', '_epa', '_state']:
            df['formal_enforcement'+c] = df['formal_enforcement'+c].where(test | (df['min_formal_enforcement_date'+c] < self.today), False)

        self.masks = df[['formal_enforcement', 'active_today', 'region', 'state', 'naics_codes',
                         'evaluation', 'evaluation_epa', 'evaluation_state', 
                         'violation_state', 'violation_epa', 'violation',
                         'violation_future', 'violation_future_epa', 'violation_future_state',
                         'handler_received', 'handler_age']].copy()

        # active mask for test set: handler received and (active today or handler under 1 year old)
        self.masks['active'] = df.handler_received & (df.active_today | (df.handler_age < handler_max_age))

        logging.info('Expanding investigations')
        _expand_investigations(df, expand_counts=investigations_expand_counts)

        # set violation in training set
        df['true'] = df[training_outcome]
        df.loc[test, 'true'] = df.loc[test, testing_outcome]
        
        self.EXCLUDE.update(exclude)
        X,y = data.Xy(df, 'true', exclude=self.EXCLUDE, include=set(include), category_classes={'state', 'region'})

        if impute:
            X.fillna(0, inplace=True)
            if normalize:
                X = data.normalize(X, train=train) 

        self.X = X
        self.y = y

def _expand_investigations(df, expand_counts):
    columns = df.columns
    list_columns = data.select_regexes(columns,
            ['investigations_.*_%s' % c for c in InvestigationsAggregator.list_columns])

    if expand_counts:
        for c in list_columns:
            data.expand_counts(df, c)

        for c in df.columns.difference(columns):
            count_column = aggregate.get_spacetime_prefix(c) + 'count'
            df[c + '_prop'] = df[c] / df[count_column]
    else:
        df.drop(list_columns, axis=1, inplace=True)

    for c in data.select_regexes(columns,
            ['investigations_.*_%s_count' % c for c in InvestigationsAggregator.bool_columns]):

        count_column = aggregate.get_spacetime_prefix(c) + 'count'
        df[c[:-5]+'prop'] = df[c] / df[count_column]
