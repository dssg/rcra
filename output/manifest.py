import logging
from datetime import date

from drain.util import day
from drain.data import FromSQL
from drain.aggregate import Aggregate, Count, days
from drain.aggregation import SpacetimeAggregation

class ManifestAggregation(SpacetimeAggregation):
    def __init__(self, spacedeltas, dates, **kwargs):
        SpacetimeAggregation.__init__(self, spacedeltas=spacedeltas, dates=dates, 
                prefix='manifest', date_column='gen_sign_date', **kwargs)

        if not self.parallel:
            self.manifest = FromSQL(
                query="""select gen_rcra_id as rcra_id, *,
                ARRAY_REMOVE(ARRAY[waste_code_1, waste_code_2, waste_code_3,
                    waste_code_4, waste_code_5, waste_code_6], NULL) as waste_codes
                from manifest.new_york where substring(gen_rcra_id for 2) = 'NY' """, 
                tables=['manifest.new_york'], parse_dates=['gen_sign_date'], target=True)
            self.inputs = [self.manifest]

    def get_aggregates(self, date, delta):
        aggregates = [
            Count(name='line_items'),
            #Count(booleans, prop=True),
            Aggregate('approx_qty', ['max','min','mean','var','std','skew','kurt'], name='approx_qty'),
            Aggregate(lambda m: m.waste_codes.apply(lambda w: sum(code[0] == 'P' for code in w)>0) ,['any'], name = 'waste_code_p'),
            Aggregate(lambda m: m.waste_codes.apply(lambda w: sum(code[0] == 'U' for code in w)>0) ,['any'], name = 'waste_code_u'),
            Aggregate(lambda m: m.waste_codes.apply(lambda w: sum(code[0] == 'D' for code in w)>0) ,['any'], name = 'waste_code_d'),
            Aggregate(lambda m: m.waste_codes.apply(lambda w: sum(code[0] == 'F' for code in w)>0) ,['any'], name = 'waste_code_f'),
            Aggregate(lambda m: m.waste_codes.apply(lambda w: sum(code[0] == 'P' | code == 'F020' 
                                                                                 | code == 'F021' 
																				 | code == 'F022'
																			     | code == 'F023'																		    																  | code == 'F026'
																				 | code == 'F027' for code in w)>0) ,['any'], name = 'waste_acute')
        ]

        return aggregates





















