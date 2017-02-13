import logging
from datetime import date
import pandas as pd

from drain.util import day
from drain.data import FromSQL, Merge
from drain.aggregate import Aggregate, Count
from drain.aggregation import SpacetimeAggregation

from epa.output import facilities

reports = FromSQL(table='output.nysdec_reports', parse_dates=['date'])
reports.target = True

class NYSDECReportsAggregation(SpacetimeAggregation):
    def __init__(self, spacedeltas, dates, parallel=True):
        SpacetimeAggregation.__init__(self, 
                inputs=[Merge(inputs=[reports, facilities], on='rcra_id')],
                spacedeltas=spacedeltas, dates=dates, 
                prefix='reports', date_column='date', parallel=parallel)

    def get_aggregates(self, date, delta):
        aggregates = [
            Count(),
            Aggregate('number_wastewater',['min','max','mean'],name='number_wastewater'),
            Aggregate('number_exempt_residuals',['min','max','mean'],name='number_exempt_residuals'),
            Aggregate('number_exempt_recycling',['min','max','mean'],name='number_exempt_recycling'),
            Aggregate('gen_qty_lbs',['min','max','mean','std'],name='gen_qty_lbs'),
            Aggregate('sys_tdr_qty_lbs',['min','max','mean','std'],name='sys_tdr_qty_lbs')
        ]
        return aggregates
