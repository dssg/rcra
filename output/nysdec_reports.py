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
            self.inputs = [FromSQL(
                            query=""" select * from nysdec_reports.gm_combined_collapsed 
                                        where report_year='2013') a       
                                    LEFT JOIN nysdec_reports.si_combined b
                                    ON (a.handler_id = b.handler_id AND a.report_year = b.report_year)) as a;""",
                            tables=['nysdec_reports.gm_combined_collapsed'], 
                            parse_dates=['report_year'],
                            target=True)]

    def get_aggregates(self, date, delta):
        aggregates = [
            Aggregate('number_wastewater',['min','max','mean','std','skew'],name='number_wastewater'),
            Aggregate('number_exempt_residuals',['min','max','mean','std','skew'],name='number_exempt_residuals'),
            Aggregate('number_exempt_recycling',['min','max','mean','std','skew'],name='number_exempt_recycling'),
            Aggregate('gen_qty_lbs',['min','max','mean','std','skew'],name='gen_qty_lbs')
        ]
        return aggregates
