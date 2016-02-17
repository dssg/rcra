import logging
from datetime import date
import pandas as pd

from drain.util import day
from drain.data import FromSQL
from drain.aggregate import Aggregate, Count
from drain.aggregation import SpacetimeAggregation

class IcisFecAggregation(SpacetimeAggregation):
    def __init__(self, spacedeltas, dates, **kwargs):
        SpacetimeAggregation.__init__(self, spacedeltas=spacedeltas, dates=dates, 
                prefix='icis_fec', date_column='activity_status_date', **kwargs)

        if not self.parallel:
            self.inputs = [FromSQL(table='output.icis_fec', 
                    parse_dates=['activity_status_date'], target=True)]

    def get_aggregates(self, date, delta):
        aggregates = [
            Count(),
            Aggregate(['total_comp_action_amt', 'total_cost_recovery_amt', 
                    'total_penalty_assessed_amt', 'fed_penalty', 'st_lcl_penalty', 
                    'total_sep', 'compliance_action_cost'], ['min', 'mean','max']),
            Aggregate(lambda i: (date - i.activity_status_date) / day, 
                    ['min', 'max'], name='activity_status_date')
        ]

        return aggregates

    def fillna_value(self, df, left, **concat_args):
        return pd.Series(0, index=df.columns)
