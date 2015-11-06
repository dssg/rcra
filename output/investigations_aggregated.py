import pandas as pd
import numpy as np
import sys

from drain import util
from drain.aggregate import aggregate, aggregate_counts
from drain import data
from epa.output.investigations import get_investigations

day = np.timedelta64(1, 'D')

bool_columns = ['citizen_complaint', 'multimedia_inspection', 'sampling', 'not_subtitle_c', 
                'corrective_action_component', 'violation_state', 'violation_epa',
                'enforcement_state', 'enforcement_epa'
]

list_columns = ['violation_types', 'violation_classes', 'enforcement_types', 'evaluation_types', 
                'focus_areas', 'land_types', 'rtc_qualifiers', 'sep_types',
                #'former_citations' ignore former citations for now
]

INVESTIGATION_COLUMNS = {
        'count': {'numerator': 1},
        'epa_count': {'numerator': 'agency_epa'},
        'state_count': {'numerator': 'agency_state'},
        
        'days_since_last_inspection': {'numerator': lambda i: (today - i['start_date']) / day, 'func': 'min'},
        'days_since_last_violation': {'numerator': lambda i: (today - i['max_violation_determined_date']) / day, 'func': 'min'},

        'max_time_to_violation': {'numerator': lambda i: (i['max_violation_determined_date'] - i['start_date']) / day, 'func': 'max'},
        'max_time_violation_to_rtc': {'numerator': lambda i: (i['max_rtc_date'] - i['max_violation_determined_date']) / day, 'func': 'max'},
        'avg_time_violation_to_rtc': {'numerator': lambda i: (i['max_rtc_date'] - i['max_violation_determined_date']) / day, 'func': 'mean'},

        # difference between schedule compliance and true RTC dates
        'max_overtime_to_compliance': {'numerator': lambda i: (i['max_rtc_date'] - i['max_scheduled_compliance_date']) / day , 'func': 'max'},
        'avg_overtime_to_compliance': {'numerator': lambda i: (i['max_rtc_date'] - i['max_scheduled_compliance_date']) / day, 'func': 'mean'},

        # init/comply columns  are indicators?
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
        'days_since_last_enforcement': {'numerator': lambda i: (today - i['max_formal_enforcement_date']) / day, 'func': 'min'},
}

for c in list_columns:
    INVESTIGATION_COLUMNS[c] = {'numerator': c, 'func':aggregate_counts}

for c in bool_columns:
    INVESTIGATION_COLUMNS[c + '_count'] = {'numerator': c}

if __name__ == '__main__':
    today = dateutil.parser.parse(sys.argv[1])
    output = sys.argv[2]

    engine = util.create_engine()

    df = get_investigations(today, engine)
    
    df2 = aggregate(df, INVESTIGATION_COLUMNS, index='rcra_id')
    columns = df2.columns
    
    for c in list_columns:
        data.expand_counts(df2, c)
    
    # add proportions for all the list columns
    for c in df2.columns.difference(columns):
            df2[c + '_prop'] = df2[c] / df2['count']
    
    # add proportions for the bool column counts
    for c in bool_columns:
        df2[c + '_prop'] = df2[c + '_count'] / df2['count']

    df2.to_hdf(output, 'df')
