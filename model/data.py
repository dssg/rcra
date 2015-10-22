from drain.data import ModelData
from drain import util
from drain.util import index_as_series
from drain import data

import os
from datetime import date
import pandas as pd
import numpy as np

class EpaData(ModelData):
    psql_dir = os.environ['EPA_PSQL_DIR'] if 'EPA_PSQL_DIR' in os.environ else ''
    DEPENDENCIES = [os.path.join(psql_dir, d) for d in ['output/evaluations' ]]

    def __init__(self, today, past_years, outcome_years=1):
        if outcome_years != 1:
            raise NotImplementedError('Currently only outcome_years=1 is implemented')

        self.today = today
        self.past_years = past_years
        self.outcome_years = outcome_years

    def read(self, directory=None):
        if directory is not None:
            self.df = pd.read_hdf(os.path.join(directory, 'df.h5'), 'df')
            return

        engine = util.create_engine()

        doy = self.today.strftime('%m-%d')
        date_min = date(self.today.year - self.past_years, self.today.month, self.today.day)
        date_max = date(self.today.year + self.outcome_years, self.today.month, self.today.day)

        df = pd.read_sql("""
select rcra_id, 
       ((extract(year from start_date)::text || '-{doy}')::date - ((extract(year from start_date)::text || '-{doy}')::date > start_date)::int * interval '1 year')::date as date,
        agency_epa, bool_or(violation) as violation,
        bool_or(formal_enforcement) as formal_enforcement
from output.evaluations 
        where start_date between '{date_min}' and '{date_max}' group by 1,2,3;
        """.format(doy=doy, date_min=date_min, date_max=date_max), engine)

        self.df = df

    def write(self, directory):
        self.df.to_hdf(os.path.join(directory, 'df.h5'), 'df', mode='w')

    def transform(self, training_state, train_years=None, testing_state=False):
        if train_years > self.past_years:
            raise ValueError('Invalid argument: train_years > past_years')
        
        df = self.df
        # TODO: use train_years

        df.set_index(['rcra_id', 'date', 'agency_epa'], inplace=True)

        train = index_as_series(df, 'date') < self.today
        test = ~train
        if not training_state:
            train = train & index_as_series(df, 'agency_epa')
        if not testing_state:
            test = test & index_as_series(df, 'agency_epa')

        df.drop(df.index[~(train | test)], inplace=True)
        train = train.loc[df.index]
        test = test.loc[df.index]
        self.cv = (train, test)
        
        df['state'] = index_as_series(df, 'rcra_id').apply(lambda i: i[:2])
        
        X,y = data.Xy(df, 'violation', exclude={'formal_enforcement'}, category_classes={'state'})
        self.X = X
        self.y = y
