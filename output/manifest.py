import os
import pandas as pd
import numpy as np
import itertools

from drain import util, data, aggregate
from drain.data import date_censor_sql, ToHDF, FromSQL, Revise
from drain.step import Step
from drain.aggregation import SpacetimeAggregation, SimpleAggregation
from drain.aggregate import Aggregate, Count, aggregate_counts, days


#Need to make manifest dictionary and change this 
from epa.output import manifest_sql


date_columns = manifest_sql.date_columns


parse_dates = ['min_' + c for c in date_columns] + \
                       ['max_' + c for c in date_columns] + ['start_date']


quantity =  ['approx_qty']

waste_type = ['unit_of_measure']


#Classes and Aggregations

class manifestAggregations(SpacetimeAggregation):
    def __init__(self, spacedeltas, dates, **kwargs):
        SpacetimeAggregation.__init__(self, spacedeltas=spacedeltas,
                dates=dates, prefix='manifest',
                date_column='gen_sign_date', **kwargs)
        if len(self.dates) !=1 and not self.parallel:
            raise ValueError('Currently only able to run one date at a time, try parallel=True')
        if not self.parallel:
            sql=manifest_sql.get_sql(self.dates[0])
            self.inputs = [Revise(sql=sql,
                id_column = ['rcra_id','gen_sign_date'],
                source_id_column = ['gen_rcra_id','gen_sign_date'],
                max_date_column = 'max_date',
                min_date_column = 'gen_start_date',
                date_column = 'gen_sign_date',
                date = self.dates[0],
                from_sql_args = {'parse_dates':parse_dates, 'target':True})
                ]
    def get_aggregates(self, date, delta):
        aggregates = [
                Count(),

                #outcomes
                Aggregate(outcomes + flag, 'any', fname=False),
                Count(outcomes + flags, prop=True),

                Aggregate(days('start_date', date), 'max', name = 'start_date_days'),
                Aggregate([days('max_' + c, date) for c in date_columns], 'max',
                    name = [c + '_days' for c in date_columns]),

                Aggregate(days('min_gen_sign_date', 'start_date'), ['min','mean','max'],'gen_sign_date')]

        if delta=='all':
            aggregates.extend([
                Aggregate([days('min_' + c, date) for c in date_columns],























