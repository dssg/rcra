import logging
from datetime import date
import re
import numpy as np

from drain.util import day
from drain.data import FromSQL
from drain.aggregate import Aggregate, Count, days
from drain.aggregation import SpacetimeAggregation

WASTE_CODE_PREFIXES = ('P', 'U', 'D', 'F')
# acute waste is defined as either P waste or one of these six F wastes
ACUTE_WASTE_REGEX = re.compile('^(P|F02[012367]$)')

class ManifestAggregation(SpacetimeAggregation):
    def __init__(self, spacedeltas, dates, **kwargs):
        SpacetimeAggregation.__init__(self, spacedeltas=spacedeltas, dates=dates, 
                prefix='manifest', date_column='gen_sign_date', **kwargs)

        if not self.parallel:
            self.manifest = FromSQL(
                query=""" select *,
                ARRAY_REMOVE(ARRAY[waste_code_1, waste_code_2, waste_code_3,
                    waste_code_4, waste_code_5, waste_code_6], NULL) as waste_codes
                from output.manifest where substring(rcra_id for 2) = 'NY' """, 
                tables=['output.manifest'], parse_dates=['gen_sign_date'], target=True)
            self.inputs = [self.manifest]

    def get_aggregates(self, date, delta):
        
        aggregates = [
            Count(name='line_items'),
            Aggregate('approx_qty', ['sum','max','min','mean','std','skew'], name='pounds_shipped'),
            Aggregate([has_waste_type(p) for p in WASTE_CODE_PREFIXES],
                ['any'], name = ['waste_code_%s' % p for p in WASTE_CODE_PREFIXES]),
            Aggregate(lambda m: m.waste_codes.apply(lambda w: sum(is_acute_waste(code) for code in w)>0),
                ['any'], name = 'waste_acute'),

            # Liquid/solid features
            Aggregate(lambda x: x.unit_of_measure.isin(['L','N','Y']), ['any'], name = 'liquid_shipped'),
            Aggregate(lambda x: np.where(x.unit_of_measure.isin(['L','N','Y']), x.approx_qty, np.zeros(np.shape(x.approx_qty))), ['sum','max','min','mean','std','skew'], name = 'pounds_liquid_shipped'),
            Aggregate(lambda x: np.where(~x.unit_of_measure.isin(['L','N','Y']), x.approx_qty, np.zeros(np.shape(x.approx_qty))), ['sum','max','min','mean','std','skew'], name = 'pounds_solid_shipped'),

            ]

        return aggregates

def has_waste_type(prefix):
    return lambda m: m.waste_codes.apply(lambda w: sum(code[0] == prefix for code in w)>0)

def is_acute_waste(code):
    return ACUTE_WASTE_REGEX.match(code) is not None
