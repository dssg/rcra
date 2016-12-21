from drain.data import FromSQL
from drain.aggregate import Aggregate
from drain.aggregation import SpacetimeAggregation

class ManifestMonthlyAggregation(SpacetimeAggregation):
    def __init__(self, spacedeltas, dates, **kwargs):
        SpacetimeAggregation.__init__(self, spacedeltas=spacedeltas, dates=dates, 
                prefix='manifest_monthly', date_column='gen_sign_month', **kwargs)

        if not self.parallel:
            self.manifest = FromSQL(
                query=""" select rcra_id, date_trunc('month', gen_sign_date) gen_sign_month, sum(approx_qty) as approx_qty
                from output.manifest where substring(rcra_id for 2) = 'NY' group by 1,2""", 
                tables=['output.manifest'], parse_dates=['gen_sign_month'], target=True)
            self.inputs = [self.manifest]

    def get_aggregates(self, date, delta):
        return [Aggregate('approx_qty', 'max')]
