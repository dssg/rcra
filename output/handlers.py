from datetime import date

from drain.util import day
from drain.data import FromSQL
from drain.aggregate import Aggregate, Count, days
from drain.aggregation import SpacetimeAggregation


HANDLER_BOOLEANS = [
       'handler_cesqg', 'handler_furnace_exemption',
       'handler_importer_activity', 'handler_include_in_br',
       'handler_land_type_county', 'handler_land_type_district',
       'handler_land_type_federal', 'handler_land_type_municipal',
       'handler_land_type_other', 'handler_land_type_private',
       'handler_land_type_state', 'handler_land_type_tribal',
       'handler_land_type_unknown', 'handler_location_eq_mailing',
       'handler_lqg', 'handler_mixed_waste_generator',
       'handler_non_notifier', 'handler_non_notifier_exempt',
       'handler_non_notifier_former', 'handler_nonprofit',
       'handler_not_generator', 'handler_onsite_burner_exemption',
       'handler_receives_waste_from_off_site', 'handler_recycler_activity',
       'handler_short_term_generator', 'handler_sqg',
       'handler_teaching_hospital', 'handler_transfer_facility',
       'handler_transporter_activity', 'handler_tsd_activity',
       'handler_underground_injection_activity',
       'handler_universal_waste_destination_facility',
       'handler_university', 'handler_used_oil_fuel_marketer_to_burner',
       'handler_used_oil_processor', 'handler_used_oil_refiner',
       'handler_used_oil_specification_marketer',
       'handler_used_oil_transfer_facility',
       'handler_used_oil_transporter', 'handler_withdrawal'
]

class HandlersAggregation(SpacetimeAggregation):
    def __init__(self, spacedeltas, dates, **kwargs):
        SpacetimeAggregation.__init__(self, spacedeltas=spacedeltas, dates=dates, 
                prefix='handlers', date_column='receive_date', **kwargs)

        if not self.parallel:
            self.handlers = FromSQL(
                query='select *, substring(rcra_id for 2) as state from output.handlers', 
                tables=['output.handlers'], parse_dates=['receive_date'], target=True)
            self.inputs = [self.handlers]

    def get_aggregates(self, date, delta):
        aggregates = [
            Count(),
            Count(HANDLER_BOOLEANS, prop=True),
            Aggregate(days('receive_date', date), 'max', name='receive_date')
        ]

        return aggregates
