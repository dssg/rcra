import logging
from datetime import date
import pandas as pd

from drain.util import day
from drain.data import FromSQL, Merge
from drain.aggregate import Aggregate, Count
from drain.aggregation import SpacetimeAggregation

from epa.output import facilities

icis = FromSQL(table='output.icis_fec', parse_dates=['activity_status_date'])
icis.target = True

class IcisFecAggregation(SpacetimeAggregation):
    def __init__(self, spacedeltas, dates, parallel=True):
        SpacetimeAggregation.__init__(self, 
                inputs=[Merge(inputs=[icis, facilities], on='rcra_id')],
                spacedeltas=spacedeltas, dates=dates, 
                prefix='icis_fec', date_column='activity_status_date', 
                parallel=parallel)

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
