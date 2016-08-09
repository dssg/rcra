import logging
from datetime import date
import pandas as pd

from drain.util import day
from drain.data import FromSQL
from drain.aggregate import Aggregate, Count
from drain.aggregation import SpacetimeAggregation

'''
boolean_columns = ['management_location_onsite', 'management_location_offsite', 'management_location_none', 
        'source_ongoing_waste', 'source_intermittent_waste', 'source_pollution_control_waste', 
        'source_spills_accidental_waste', 'source_remediation_waste', 
        'form_mixed_media', 'form_inorganic_liquids', 'form_organic_liquids', 'form_inorganic_solids', 
        'form_organic_solids', 'form_inorganic_sludges', 'form_organic_sludges', 
        'management_reclamation_recovery', 'management_destruction_prior_to_disposal', 
        'management_disposal', 'management_transfer_offsite', 'federal_waste', 'wastewater']

numeric_columns = ['total_generated_tons', 'total_managed_tons', 'total_shipped_tons', 'total_received_tons']
'''

class NYSDECReportsAggregation(SpacetimeAggregation):
    def __init__(self, spacedeltas, dates, **kwargs):
        SpacetimeAggregation.__init__(self, spacedeltas=spacedeltas, dates=dates, 
                prefix='br', date_column='date', **kwargs)

        if not self.parallel:
            self.inputs = [FromSQL(
                            query=""" select * from nysdec_reports.gm_combined_collapsed 
                                        where report_year='2013') a       
                                    LEFT JOIN nysdec_reports.si_combined b
                                    ON (a.handler_id = b.handler_id AND a.report_year = b.report_year)) as a;""",
                            tables=['nysdec_reports.gm_combined_collapsed','nysdec_reports.si_combined'], 
                            parse_dates=['report_year'],
                            target=True)]

    def get_aggregates(self, date, delta):
        aggregates = [
            Count(name='line_items'),
            Aggregate('total_generated_tons',['min','max','mean','std','skew'],name='generated_tons'),
            Aggregate('total_managed_tons',['min','max','mean','std','skew'],name='managed_tons'),
            Aggregate('total_shipped_tons',['min','max','mean','std','skew'],name='shipped_tons'),
            Aggregate('total_received_tons',['min','max','mean','std','skew'],name='received_tons')
        ]
        return aggregates
