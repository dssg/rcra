import pandas as pd
import numpy as np
import sys
import os
import dateutil
from datetime import date

from drain import util
from drain.aggregate import aggregate, aggregate_counts, SpacetimeAggregator
from drain import data
from epa.output.investigations import get_investigations

day = np.timedelta64(1, 'D')

class InvestigationsAggregator(SpacetimeAggregator):
    bool_columns = ['citizen_complaint', 'multimedia_inspection', 'sampling', 'not_subtitle_c', 
                    'corrective_action_component', 'violation_state', 'violation_epa',
                    'enforcement_state', 'enforcement_epa'
    ]
        
    list_columns = ['violation_types', 'violation_classes', 'enforcement_types', 'evaluation_types', 
                    'focus_areas', 'land_types', 'rtc_qualifiers', 'sep_types',
                    #'former_citations' ignore former citations for now
    ]
 
    def get_columns(self, date):
        columns = {
                'count': {'numerator': 1},
                'epa_count': {'numerator': 'agency_epa'},
                'state_count': {'numerator': 'agency_state'},
                
                'days_since_last_inspection': {'numerator': lambda i: (date - i['start_date']) / day, 'func': 'min'},
                'days_since_last_violation': {'numerator': lambda i: (date - i['max_violation_determined_date']) / day, 'func': 'min'},
        
                'max_time_to_violation': {'numerator': lambda i: (i['max_violation_determined_date'] - i['start_date']) / day, 'func': 'max'},
                'max_time_violation_to_rtc': {'numerator': lambda i: (i['max_rtc_date'] - i['max_violation_determined_date']) / day, 'func': 'max'},
                'avg_time_violation_to_rtc': {'numerator': lambda i: (i['max_rtc_date'] - i['max_violation_determined_date']) / day, 'func': 'mean'},
        
                # difference between schedule compliance and true RTC dates
                'max_overtime_to_compliance': {'numerator': lambda i: (i['max_rtc_date'] - i['max_scheduled_compliance_date']) / day , 'func': 'max'},
                'avg_overtime_to_compliance': {'numerator': lambda i: (i['max_rtc_date'] - i['max_scheduled_compliance_date']) / day, 'func': 'mean'},
        
               
                'max_diff_fmp_paid': {'numerator': lambda i: i['max_final_monetary_amount'] - i['max_paid_amount'], 'func': 'max'},
                'max_diff_fmp_pmp': {'numerator': lambda i: i['max_final_monetary_amount'] - i['max_proposed_penalty_amount'], 'func': 'max'},
                'max_paid_amount': {'numerator': 'max_paid_amount', 'func': 'max'},
                'avg_paid_amount': {'numerator': 'max_paid_amount', 'func': 'mean'},
                'avg_fmp_amount': {'numerator': 'max_final_monetary_amount', 'func': 'mean'},
                'avg_pmp_amount': {'numerator': 'max_proposed_penalty_amount', 'func': 'mean'},
        
                # SEP Features
                'max_paid_amount': {'numerator': 'max_expenditure_amount', 'func': 'max'},
                'max_time_to_sep_completion': {'numerator': lambda i: (i['max_sep_actual_completion_date'] - i['max_sep_scheduled_completion_date']) / day, 'func': 'max'},
                'min_time_to_sep_completion': {'numerator': lambda i: (i['max_sep_actual_completion_date'] - i['max_sep_scheduled_completion_date']) / day, 'func': 'min'},
                'max_time_to_sep_default': {'numerator': lambda i: (i['min_sep_defaulted_date'] - i['max_sep_scheduled_completion_date']) / day, 'func': 'max'},
                'min_time_to_sep_default': {'numerator': lambda i: (i['min_sep_defaulted_date'] - i['max_sep_scheduled_completion_date']) / day, 'func': 'min'},
        
                # Enforcement features
                'days_since_last_enforcement': {'numerator': lambda i: (date - i['max_formal_enforcement_date']) / day, 'func': 'min'},
        }
        
        for c in self.list_columns:
            columns[c] = {'numerator': c, 'func':aggregate_counts}
        
        for c in self.bool_columns:
            columns[c + '_count'] = {'numerator': c}

        return columns
        
    def __init__(self, basedir, psql_dir=''):
        SpacetimeAggregator.__init__(self, 
                {'facility':[-1]},
                ['rcra_id'],
                [date(y,1,1) for y in xrange(2002,2016+1)],
                'investigations',
                basedir)

        self.DEPENDENCIES = ['output/investigations.py', os.path.join(psql_dir, 'output/investigations')]


    def aggregate(self, date):
        engine = util.create_engine()

        df = get_investigations(date, engine)
        columns = self.get_columns(date)

        df2 = aggregate(df, columns, index='rcra_id')
        df2.reset_index(inplace=True)
        return df2

    def expand(self, df):
        columns = df.columns
        
        for c in self.list_columns:
            data.expand_counts(df, c)
        
        # add proportions for all the list columns
        for c in df.columns.difference(columns):
                df[c + '_prop'] = df[c] / df['count']
        
        # add proportions for the bool column counts
        for c in self.bool_columns:
            df[c + '_prop'] = df[c + '_count'] / df['count']

        return df
