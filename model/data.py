from drain.data import ModelData, censor_column
from drain import util
from drain.util import index_as_series
from drain import data

from epa.output.investigations_aggregated import InvestigationsAggregator

import os
from datetime import date
import pandas as pd
import numpy as np

class EpaData(ModelData):
    psql_dir = os.environ['PSQL_DIR'] if 'PSQL_DIR' in os.environ else ''
    data_dir = os.environ['DATA_DIR'] if 'DATA_DIR' in os.environ else ''
    DEPENDENCIES = [os.path.join(psql_dir, d) for d in ['output/investigations', 'output/handlers', 'output/region_states' ]]

    EXCLUDE = {'formal_enforcement_epa', 'formal_enforcement_state', 'formal_enforcement',
               'min_formal_enforcement_date_epa', 'min_formal_enforcement_date_state', 'min_formal_enforcement_date',
               'receive_date', 'violation_epa', 'violation_state', 'violation',
               'violation_future_epa', 'violation_future_state', 'violation_future',
               'active_today', 'naics_codes'}
    DATES = {'date', 'min_formal_enforcement_date_epa', 'min_formal_enforcement_date_state', 
               'min_formal_enforcement_date', 'receive_date'}

    def __init__(self, min_year, max_year, min_predict_year, max_predict_year, month=1, day=1, outcome_years=1):
        if outcome_years != 1:
            raise NotImplementedError('Currently only outcome_years=1 is implemented')

        self.min_year = min_year
        self.max_year = max_year
        self.month = month
        self.day = day
        self.outcome_years = outcome_years
        self.min_predict_year = min_predict_year
        self.max_predict_year = max_predict_year

    def read(self, directory=None):
        if directory is not None:
            self.df = pd.read_hdf(os.path.join(directory, 'df.h5'), 'df')
            return

        engine = util.create_engine()

        doy = '%02d-%02d' % (self.month, self.day)
        date_min = date(self.min_year, self.month, self.day)
        date_max = date(self.max_year + self.outcome_years, self.month, self.day)

# TODO: state is missing when handler is missing
# move state, hnaics region and active to separate table called output.facilities
        sql ="""
with investigations as (
select rcra_id,
       ((extract(year from start_date)::text || '-{doy}')::date - ((extract(year from start_date)::text || '-{doy}')::date > start_date)::int * interval '1 year')::date as date,
        true as evaluated,

        bool_or(agency_epa) as agency_epa,
        bool_or(CASE WHEN agency_epa THEN violation ELSE null END) as violation_epa, -- was there a violation in an epa inspection? null if no epa inspections
        bool_or(CASE WHEN agency_epa THEN null ELSE violation END) as violation_state, -- was there a violation in state inspection? null if no state inspections
        bool_or(violation) as violation,

        bool_or(CASE WHEN agency_epa THEN formal_enforcement ELSE null END) as formal_enforcement_epa,
        bool_or(CASE WHEN agency_epa THEN null ELSE formal_enforcement END) as formal_enforcement_state,
        bool_or(formal_enforcement) as formal_enforcement,

        min(CASE WHEN agency_epa THEN formal_enforcement_date ELSE null END) as min_formal_enforcement_date_epa,
        min(CASE WHEN agency_epa THEN null ELSE formal_enforcement_date END) as min_formal_enforcement_date_state,
        min(formal_enforcement_date) as min_formal_enforcement_date
        
from output.investigations 
        where start_date between '{date_min}' and '{date_max}'
        group by 1,2
),

active as (
    select rcra_id, (year::text || '-{doy}')::date
    from output.facilities
    join generate_series({min_predict_year}, {max_predict_year}) as year on 1=1
    where active_today
),

active_not_investigated as (
    select a.rcra_id, a.date, false as evaluated,
        null::bool, null::bool, null::bool, null::bool,
        null::bool, null::bool, null::bool,
        null::date, null::date, null::date
    from active a left join investigations i using (rcra_id, date)
    where i.rcra_id is null
),

facility_years as (
    select * from investigations
    UNION ALL
    select * from active_not_investigated
),

future as (
    select i1.rcra_id, i1.date,
        bool_or(CASE WHEN i2.agency_epa THEN i2.violation ELSE null END) as violation_future_epa,
        bool_or(CASE WHEN i2.agency_epa THEN null ELSE i2.violation END) as violation_future_state,
        bool_or(i2.violation) as violation_future
    from facility_years i1 join output.investigations i2
        on i1.rcra_id = i2.rcra_id and i1.date <= i2.start_date
    group by 1,2
)

select distinct on(i.rcra_id, date) *,
    h.rcra_id is not null as handler_received,
    date - receive_date as handler_age

from facility_years i
left join future using (rcra_id, date)
left join output.facilities using (rcra_id)
left join output.handlers h
    on h.rcra_id = i.rcra_id and i.date > h.receive_date

where evaluated or (h.rcra_id is not null)
order by i.rcra_id, date, receive_date desc
"""
        df = pd.read_sql(sql.format(doy=doy, date_min=date_min, date_max=date_max, min_predict_year=self.min_predict_year, max_predict_year=self.max_predict_year), engine)
        df = _drop_handler_rcra_id(df)

        investigations_aggregator = InvestigationsAggregator(os.path.join(self.data_dir, 'output/aggregated/'))
        agg = investigations_aggregator.read(left=df)
        agg = investigations_aggregator.expand(agg)

        # TODO: prefix in SpacetimeAggregator.read()
        util.prefix_columns(agg, 'investigations_', ['rcra_id', 'date'])
        df = df.merge(agg, on=['rcra_id', 'date'], how='left')

        df['naics1'] = df.naics_codes.dropna().apply(lambda n: set(i[0] for i in n) )
        df['naics2'] = df.naics_codes.dropna().apply(lambda n: set(i[0:2] for i in n) )
        data.binarize_set(df, 'naics1')
        data.binarize_set(df, 'naics2')

        self.df = df

    def write(self, directory):
        self.df.to_hdf(os.path.join(directory, 'df.h5'), 'df', mode='w')

    def transform(self, year, training_state, train_years=None,
            testing_state=False, # whether or not the test set should be evaluated by epa, i.e. agency_epa=True
            testing_evaluated=False, # True means only predict on evaluated (labeled) facilities
            training_outcome = 'violation_epa', testing_outcome='violation_epa',
            region = 0,
            exclude=[], include=[],
#            spacetime_normalize = None,
            impute_days_since=False,
            impute=True, normalize=True):
        if year - train_years < self.min_year:
            raise ValueError('Invalid argument: year - train_years < min_year')

        self.today = date(year, self.month, self.day)
        df = self.df
        if region != 0:
            df.drop(df.index[~(df.region == region)], inplace=True)

        min_date = date(year-train_years, self.month, self.day)
        max_date = date(year, self.month, self.day)
        df = df.loc[df.index[(df.date >= min_date) & (df.date <= max_date)]]

        df.set_index(['rcra_id', 'date'], inplace=True)
        df.rename(columns={'handler_state':'state'}, inplace=True)

        train = index_as_series(df, 'date') < self.today
        test = ~train
        train = train & df.evaluated

        if not training_state:
            train = train & df.agency_epa
        if testing_evaluated:
            test = test & df.evaluated
        else:
            if not (self.min_predict_year <= year <= self.max_predict_year):
                raise ValueError('Cannot predict on unevaluated facilities: {1} not between {2} and {3}'.format(
                        year, self.min_predict_year, self.max_predict_year))

        df,train,test = data.train_test_subset(df, train, test)
        self.cv = (train, test)

        # censor formal enforcements based on corresponding min date
        for c in ['', '_epa', '_state']:
            df['formal_enforcement'+c] = df['formal_enforcement'+c].where(test | (df['min_formal_enforcement_date'+c] < self.today), False)

        self.masks = df[['formal_enforcement', 'active_today', 'region', 'state', 'naics_codes',
                         'evaluated', 'violation_state', 'violation_epa', 'violation', 'agency_epa', 
                          'handler_received', 'violation_future', 'violation_future_epa', 'violation_future_state']]

        # set violation in training set
        df['true'] = df[training_outcome].copy()
        df.loc[test, 'true'] = df.loc[test, testing_outcome].copy()
        df.loc[test, 'agency_epa'] = not testing_state
        
        self.EXCLUDE.update(exclude)
        X,y = data.Xy(df, 'true', exclude=self.EXCLUDE, include=set(include), category_classes={'state', 'region'})

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
