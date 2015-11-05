from drain.data import ModelData, censor_column
from drain import util
from drain.util import index_as_series
from drain import data

import os
from datetime import date
import pandas as pd
import numpy as np

class EpaData(ModelData):
    psql_dir = os.environ['PSQL_DIR'] if 'PSQL_DIR' in os.environ else ''
    DEPENDENCIES = [os.path.join(psql_dir, d) for d in ['output/investigations', 'output/handlers' ]]

    EXCLUDE = {'formal_enforcement', 'receive_date'}

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
with evaluations as (

select rcra_id, 
       ((extract(year from start_date)::text || '-{doy}')::date - ((extract(year from start_date)::text || '-{doy}')::date > start_date)::int * interval '1 year')::date as date,
        agency_epa, bool_or(violation) as violation,
        bool_or(CASE WHEN start_date < '{today}' THEN {formal_enforcement} ELSE formal_enforcement END) as formal_enforcement -- censor formal_enforcement in the training set but not in the test set
from output.investigations
        where start_date between '{date_min}' and '{date_max}' group by 1,2,3
)

select distinct on(rcra_id, date) *, h.rcra_id is not null as handler_not_null from evaluations e
join output.handlers h using (rcra_id)
where e.date > h.receive_date
order by rcra_id, date, receive_date desc
        """.format(today=self.today, doy=doy, date_min=date_min, date_max=date_max, formal_enforcement=censor_column('formal_enforcement_date', self.today, 'formal_enforcement')), engine)

        self.df = df

    def write(self, directory):
        self.df.to_hdf(os.path.join(directory, 'df.h5'), 'df', mode='w')

    def transform(self, training_state, train_years=None, testing_state=False, exclude=[], include=[], impute=True, normalize=True):
        if train_years > self.past_years:
            raise ValueError('Invalid argument: train_years > past_years')
        
        df = self.df
        # TODO: use train_years

        df.set_index(['rcra_id', 'date', 'agency_epa'], inplace=True)
        df.rename(columns={'handler_state':'state'}, inplace=True)

        train = index_as_series(df, 'date') < self.today
        test = ~train
        if not training_state:
            train = train & index_as_series(df, 'agency_epa')
        if not testing_state:
            test = test & index_as_series(df, 'agency_epa')

        df,train,test = data.train_test_subset(df, train, test)
        self.cv = (train, test)

        self.masks = df[['formal_enforcement']]
        
        self.EXCLUDE.update(exclude)
        print self.EXCLUDE
        X,y = data.Xy(df, 'violation', exclude=self.EXCLUDE, include=set(include), category_classes={'state'})

        if impute:
            X.fillna(0, inplace=True)
            if normalize:
                X = data.normalize(X, train=train) 

        self.X = X
        self.y = y
