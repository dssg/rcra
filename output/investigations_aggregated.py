import sys
import os
import dateutil
import logging
from datetime import date, datetime

import pandas as pd
import numpy as np

from drain import util, aggregate, data
from drain.aggregate import Aggregate, Count, aggregate_counts, SpacetimeAggregator, Spacedeltas

from epa.output.investigations import get_investigations

day = np.timedelta64(1, 'D')

class InvestigationsAggregator(SpacetimeAggregator):
    # these are booleans that get summed
    bool_columns = ['citizen_complaint', 'multimedia_inspection', 'sampling', 'not_subtitle_c', 
                    'corrective_action_component', 'violation_state', 'violation_epa',
                    'enforcement_state', 'enforcement_epa'
    ]
    
    # these are arrays that get concatenated and then counted and proportioned
    list_columns = ['violation_types', 'violation_classes', 'enforcement_types', 'evaluation_types', 
                    'focus_areas', 'land_types', 'rtc_qualifiers', 'sep_types',
                    #'former_citations' ignore former citations for now...
    ]
            
    def __init__(self, basedir, psql_dir=''):
        SpacetimeAggregator.__init__(self, 
                spacedeltas = {
                    'facility':Spacedeltas('rcra_id',['all', '5y', '2y', '1y']),
                    'state':Spacedeltas('state',['5y', '2y', '1y']) 
                },
                dates = [date(y,1,1) for y in xrange(2004,2014+1)],
                prefix = 'investigations',
                basedir = basedir,
                date_col = 'start_date')

        self.DEPENDENCIES = ['output/investigations.py', os.path.join(psql_dir, 'output/investigations')]

        columns = aggregate._collect_columns(self.get_aggregates(None))
        self.dtypes = {c: np.float32 for c in columns.difference(self.list_columns)}

    def get_data(self, date):
        engine = util.create_engine()
        logging.info('Reading investigations %s' % date)
        df = get_investigations(date, engine)

        return df

    def get_aggregates(self, date, data=None):
         aggregates =  [
             Count(),
             Count('agency_epa', name='epa', prop=True),
             Count('agency_state', name='state', prop=True),
             Aggregate(lambda i: (date - i['start_date']) / day, ['min','max'], 'days_since_evaluation'),
             Aggregate(lambda i: (date - i['max_violation_determined_date']) / day, ['min','max'], 'days_since_violation'),
             Aggregate(lambda i: (date - i['max_formal_enforcement_date']) / day, 'min', 'days_since_enforcement'),
            
             Aggregate(lambda i: (i['max_violation_determined_date'] - i['start_date']) / day, 'max', 'evaluation_to_violation'),
             Aggregate(lambda i: (i['max_rtc_date'] - i['max_violation_determined_date']) / day, ['max','mean'], 'violation_to_rtc'),
             Aggregate(lambda i: (i['max_rtc_date'] - i['max_scheduled_compliance_date']) / day, ['max', 'mean'], 'overtime'),

             Aggregate(lambda i: i['max_final_monetary_amount'] - i['max_paid_amount'], 'max', 'diff_fmp_paid'),
             Aggregate(lambda i: i['max_final_monetary_amount'] - i['max_proposed_penalty_amount'], 'max', 'diff_fmp_mpm'),
             Aggregate('max_paid_amount', ['max', 'mean', 'min']),
             Aggregate('max_final_monetary_amount', 'mean'),
             Aggregate('max_proposed_penalty_amount', 'mean'),

             # SEP
             Aggregate('max_expenditure_amount', 'max'),
             Aggregate(lambda i: (i['max_sep_actual_completion_date'] - i['max_sep_scheduled_completion_date']) / day, 
                     ['max', 'min'], 'time_to_sep_completion'),
             Aggregate(lambda i: (i['min_sep_defaulted_date'] - i['max_sep_scheduled_completion_date']) / day,
                     ['max', 'min'], 'time_to_sep_default'),
         ]

         aggregates.extend([Aggregate(c, aggregate_counts, function_names=False) for c in self.list_columns])
         aggregates.extend([Count(c, prop=True) for c in self.bool_columns])

         return aggregates
