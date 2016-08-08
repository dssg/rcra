import logging
from datetime import date
import re

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
                query="""select gen_rcra_id as rcra_id, *,
                ARRAY_REMOVE(ARRAY_REMOVE(
                    ARRAY[waste_code_1, waste_code_2, waste_code_3,
                          waste_code_4, waste_code_5, waste_code_6], 
                    NULL),'') as waste_codes 
                from manifest.new_york where substring(gen_rcra_id for 2) = 'NY' """,
                # Puts waste codes into array and removes NULLS and empty strings 
                tables=['manifest.new_york'], parse_dates=['gen_sign_date'], target=True)
            self.inputs = [self.manifest]

    def get_aggregates(self, date, delta):
        
        aggregates = [
            Count(name='line_items'),
            #Count(booleans, prop=True),
            Aggregate('approx_qty', ['max','min','mean','std','skew'], name='approx_qty'),
            Aggregate([has_waste_type(p) for p in WASTE_CODE_PREFIXES],
                ['any'], name = ['waste_code_%s' % p for p in WASTE_CODE_PREFIXES]),
            Aggregate(lambda m: m.waste_codes.apply(lambda w: sum(is_acute_waste(code) for code in w)>0),
                ['any'], name = 'waste_acute') ]

        return aggregates

def has_waste_type(prefix):
    return lambda m: m.waste_codes.apply(lambda w: sum(code[0] == prefix for code in w)>0)

def is_acute_waste(code):
    return ACUTE_WASTE_REGEX.match(code) is not None
