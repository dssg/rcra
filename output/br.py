import logging
from datetime import date
import pandas as pd

from drain.util import day
from drain.data import FromSQL, Merge
from drain.aggregate import Aggregate, Count
from drain.aggregation import SpacetimeAggregation

from epa.output import facilities


boolean_columns = ['management_location_onsite', 'management_location_offsite', 'management_location_none', 
        'source_ongoing_waste', 'source_intermittent_waste', 'source_pollution_control_waste', 
        'source_spills_accidental_waste', 'source_remediation_waste', 
        'form_mixed_media', 'form_inorganic_liquids', 'form_organic_liquids', 'form_inorganic_solids', 
        'form_organic_solids', 'form_inorganic_sludges', 'form_organic_sludges', 
        'management_reclamation_recovery', 'management_destruction_prior_to_disposal', 
        'management_disposal', 'management_transfer_offsite', 'federal_waste', 'wastewater']

numeric_columns = ['total_generated_tons', 'total_managed_tons', 'total_shipped_tons', 'total_received_tons']

br = FromSQL(table='output.br', parse_dates=['date'])
br.target = True

class BrAggregation(SpacetimeAggregation):
    def __init__(self, spacedeltas, dates, parallel=True):
        SpacetimeAggregation.__init__(self, 
                inputs=[Merge(inputs=[br, facilities], on='rcra_id')],
                spacedeltas=spacedeltas, dates=dates, 
                prefix='br', date_column='date', parallel=parallel)

    def get_aggregates(self, date, delta):
        aggregates = [
            Count(name='line_items'),
            Aggregate('total_generated_tons',['min','max','mean','std','skew'],name='generated_tons'),
            Aggregate('total_managed_tons',['min','max','mean','std','skew'],name='managed_tons'),
            Aggregate('total_shipped_tons',['min','max','mean','std','skew'],name='shipped_tons'),
            Aggregate('total_received_tons',['min','max','mean','std','skew'],name='received_tons')



        ]
        return aggregates
