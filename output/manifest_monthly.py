from drain.data import FromSQL
from drain.aggregate import Aggregate
from drain.aggregation import SpacetimeAggregation

manifest_monthly = FromSQL(
    query=""" select rcra_id, date_trunc('month', gen_sign_date) gen_sign_month, 
        sum(approx_qty) as approx_qty
    from output.manifest group by 1,2""", 
    tables=['output.manifest'], parse_dates=['gen_sign_month'])
manifest_monthly.target = True

class ManifestMonthlyAggregation(SpacetimeAggregation):
    def __init__(self, spacedeltas, dates, parallel=True):
        SpacetimeAggregation.__init__(self, inputs=[manifest_monthly],
                spacedeltas=spacedeltas, dates=dates, 
                prefix='manifest_monthly', date_column='gen_sign_month', 
                parallel=parallel)

    def get_aggregates(self, date, delta):
        return [Aggregate('approx_qty', 'max')]
