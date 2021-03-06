import logging
from datetime import date
import re
import numpy as np

from drain.util import day, date_to_days
from drain.data import FromSQL, Merge
from drain.aggregate import Aggregate, Count, days
from drain.aggregation import SpacetimeAggregation

from . import facilities

WASTE_CODE_PREFIXES = ('P', 'U', 'D', 'F')
# acute waste is defined as either P waste or one of these six F wastes
ACUTE_WASTE_REGEX = re.compile('^(P|F02[012367]$)')

manifest = FromSQL(query=
    """ select *,
    ARRAY_REMOVE(ARRAY[waste_code_1, waste_code_2, waste_code_3,
        waste_code_4, waste_code_5, waste_code_6], NULL) as waste_codes
    from output.manifest""", 
    tables=['output.manifest'], parse_dates=['gen_sign_date'])
manifest.target = True


class ManifestAggregation(SpacetimeAggregation):
    def __init__(self, spacedeltas, dates, parallel=True):
        SpacetimeAggregation.__init__(self, 
                inputs=[Merge(inputs=[manifest, facilities], on='rcra_id')], 
                spacedeltas=spacedeltas, dates=dates, 
                prefix='manifest', date_column='gen_sign_date', 
                parallel=parallel)

    def get_aggregates(self, date, delta):
        # pandas bug prevents us from doing 
        # Aggregate('gen_sign_date', lambda d: max(d.max() - d.min() / day, 1))
        date_range = Aggregate(lambda m: date_to_days(m.gen_sign_date), lambda d: max((d.max() - d.min()),1), name='gen_sign_date', fname='range_days')
        aggregates = [
            Count(name='line_items'),
            Aggregate('gen_sign_date', 'nunique'),
            date_range,
            Aggregate('approx_qty', 'sum')/date_range,
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

        if delta == 'all':
            aggregates.append(
                    Aggregate(days('gen_sign_date', date), 
                              ['max','min'], name='gen_sign_date'))

        return aggregates

def has_waste_type(prefix):
    return lambda m: m.waste_codes.apply(lambda w: sum(code[0] == prefix for code in w)>0)

def is_acute_waste(code):
    return ACUTE_WASTE_REGEX.match(code) is not None
