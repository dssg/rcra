import logging
from datetime import date

from drain.util import day
from drain.data import FromSQL
from drain.aggregate import Aggregate, Count, days
from drain.aggregation import SpacetimeAggregation

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
        booleans = [c for c in self.handlers.get_result().columns 
                if c not in ('rcra_id', 'receive_date', 'state', 'handler_id')]
        aggregates = [
            Count(),
            Count(booleans, prop=True),
            Aggregate(days('receive_date', date), 'max', name='receive_date')
        ]

        return aggregates
