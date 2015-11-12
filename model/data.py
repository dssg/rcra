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

    EXCLUDE = {'formal_enforcement', 'receive_date', 'min_formal_enforcement_date'}

    def __init__(self, min_year, max_year, month=1, day=1, outcome_years=1):
        if outcome_years != 1:
            raise NotImplementedError('Currently only outcome_years=1 is implemented')

        self.min_year = min_year
        self.max_year = max_year
        self.month = month
        self.day = day
        self.outcome_years = outcome_years

    def read(self, directory=None):
        if directory is not None:
            self.df = pd.read_hdf(os.path.join(directory, 'df.h5'), 'df')
            return

        engine = util.create_engine()

        doy = '%02d-%02d' % (self.month, self.day)
        date_min = date(self.min_year, self.month, self.day)
        date_max = date(self.max_year + self.outcome_years, self.month, self.day)

        df = pd.read_sql("""
with evaluations as (

select rcra_id, 
       ((extract(year from start_date)::text || '-{doy}')::date - ((extract(year from start_date)::text || '-{doy}')::date > start_date)::int * interval '1 year')::date as date,
        agency_epa, bool_or(violation) as violation,
        bool_or(formal_enforcement) as formal_enforcement,
        min(formal_enforcement_date) as min_formal_enforcement_date
from output.investigations
        where start_date between '{date_min}' and '{date_max}' group by 1,2,3
)

select distinct on(e.rcra_id, date, agency_epa) *, h.rcra_id is not null as handler_not_null from evaluations e
left join output.handlers h on h.rcra_id = e.rcra_id and e.date > h.receive_date
order by e.rcra_id, date, agency_epa, receive_date desc
        """.format(doy=doy, date_min=date_min, date_max=date_max), engine)

        df = _drop_handler_rcra_id(df)
        self.df = df

    def write(self, directory):
        self.df.to_hdf(os.path.join(directory, 'df.h5'), 'df', mode='w')

    def transform(self, year, training_state, train_years=None, testing_state=False, exclude=[], include=[],
            impute=True, normalize=True):
        if year - train_years < self.min_year:
            raise ValueError('Invalid argument: year - train_years < min_year')

        # TODO: add formal_enforcement as possible outcome
        # censor it based on formale_enforcement_min_date

        self.today = date(year, self.month, self.day)
        df = self.df

        min_date = date(year-train_years, self.month, self.day)
        max_date = date(year, self.month, self.day)
        df = df.loc[df.index[(df.date >= min_date) & (df.date <= max_date)]]

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
        X,y = data.Xy(df, 'violation', exclude=self.EXCLUDE, include=set(include), category_classes={'state'})

        if impute:
            X.fillna(0, inplace=True)
            if normalize:
                X = data.normalize(X, train=train) 

        self.X = X
        self.y = y

# query returns two rcra id, one from investigations and one from handlers
# drop the one from handlers because it has nulls
def _drop_handler_rcra_id(df):
    ids = [i for i in xrange(len(df.columns)) if df.columns[i] == 'rcra_id']
    j = ids[np.argmin( map(lambda i: df.ix[:,i].notnull().sum(), ids))]
    keep = [True] * len(df.columns)
    keep[j] = False
    return df.ix[:,keep]
