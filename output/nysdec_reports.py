import logging
from datetime import date
import pandas as pd

from drain.util import day
from drain.data import FromSQL
from drain.aggregate import Aggregate, Count
from drain.aggregation import SpacetimeAggregation

class NYSDECReportsAggregation(SpacetimeAggregation):
    def __init__(self, spacedeltas, dates, **kwargs):
        SpacetimeAggregation.__init__(self, spacedeltas=spacedeltas, dates=dates, 
                prefix='reports', date_column='date', **kwargs)

        if not self.parallel:
            self.inputs = [FromSQL(table='output.nysdec_reports', 
                            parse_dates=['date'],
                            target=True)]

    def get_aggregates(self, date, delta):
        aggregates = [
            Aggregate('number_wastewater',['min','max','mean'],name='number_wastewater'),
            Aggregate('number_exempt_residuals',['min','max','mean'],name='number_exempt_residuals'),
            Aggregate('number_exempt_recycling',['min','max','mean'],name='number_exempt_recycling'),
            Aggregate('gen_qty_lbs',['min','max','mean','std'],name='gen_qty_lbs'),
            Aggregate('sys_tdr_qty_lbs',['min','max','mean','std'],name='sys_tdr_qty_lbs')
        ]
        return aggregates
