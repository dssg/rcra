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

    EXCLUDE = {'formal_enforcement_epa', 'formal_enforcement_state', 'formal_enforcement',
               'min_formal_enforcement_date_epa', 'min_formal_enforcement_date_state', 'min_formal_enforcement_date',
               'receive_date', 'violation_epa', 'violation_state'}

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
        bool_or(agency_epa) as agency_epa,
        bool_or(violation and agency_epa) as violation_epa,
        bool_or(violation and (not agency_epa)) as violation_state,
        bool_or(violation) as violation,

        bool_or(formal_enforcement and agency_epa) as formal_enforcement_epa,
        bool_or(formal_enforcement and (not agency_epa)) as formal_enforcement_state,
        bool_or(formal_enforcement) as formal_enforcement,

        min(CASE WHEN agency_epa THEN formal_enforcement_date ELSE null END) as min_formal_enforcement_date_epa,
        min(CASE WHEN agency_epa THEN null ELSE formal_enforcement_date END) as min_formal_enforcement_date_state,
        min(formal_enforcement_date) as min_formal_enforcement_date,

        bool_or(active_site != '-----') as active -- bool_or is unnecessary since they are all the same
from output.investigations left join rcra.facilities
            on rcra_id = id_number
        where start_date between '{date_min}' and '{date_max}'
        group by 1,2
)

select distinct on(e.rcra_id, date) *, h.rcra_id is not null as handler_not_null from evaluations e
left join output.handlers h on h.rcra_id = e.rcra_id and e.date > h.receive_date
order by e.rcra_id, date, receive_date desc
        """.format(doy=doy, date_min=date_min, date_max=date_max), engine)

        df = _drop_handler_rcra_id(df)
        self.df = df

    def write(self, directory):
        self.df.to_hdf(os.path.join(directory, 'df.h5'), 'df', mode='w')

    def transform(self, year, training_state, train_years=None, testing_state=False,
            training_outcome = 'violation_epa', testing_outcome='violation_epa',
            exclude=[], include=[],
            impute=True, normalize=True):
        if year - train_years < self.min_year:
            raise ValueError('Invalid argument: year - train_years < min_year')


        self.today = date(year, self.month, self.day)
        df = self.df

        min_date = date(year-train_years, self.month, self.day)
        max_date = date(year, self.month, self.day)
        df = df.loc[df.index[(df.date >= min_date) & (df.date <= max_date)]]

        df.set_index(['rcra_id', 'date'], inplace=True)
        df.rename(columns={'handler_state':'state'}, inplace=True)

        train = index_as_series(df, 'date') < self.today
        test = ~train
        if not training_state:
            train = train & df.agency_epa
        if not testing_state:
            test = test & df.agency_epa

        df,train,test = data.train_test_subset(df, train, test)
        self.cv = (train, test)

        # censor formal enforcements based on corresponding min date
        for c in ['', '_epa', '_state']:
            df['formal_enforcement'+c] = df['formal_enforcement'+c].where(test | (df['min_formal_enforcement_date'+c] < self.today), False)
        # set violation in training set
        df.loc[train, 'violation'] = df.loc[train, training_outcome].copy()
        df.loc[test, 'violation'] = df.loc[test, training_outcome].copy()

        self.masks = df[['formal_enforcement']].copy()
        self.masks['active'] = df['active'] & df['handler_not_null']
        df.drop('active', axis=1, inplace=True)
        
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
