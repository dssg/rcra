import pandas as pd
import numpy as np
import sys
import datetime

from drain import util
from drain.aggregate import aggregate
from drain.util import PgSQLDatabase,prefix_columns

INSPECTION_COLUMNS = {
        'inspection_count': {'numerator':1},
        'days_since_last_inspection': {'numerator': lambda i: (today - i['start_date']) / day, 'func': 'min'},
        'days_since_last_violation': {'numerator': lambda i: (today - i['max_violation_determined_date']) / day, 'func': 'min'},
        
        'citizen_complaints': {'numerator': 'citizen_complaint'},
        'multimedia_inspections': {'numerator': 'multimedia_inspection'},
        'sampling_count': {'numerator': 'sampling'},
        'not_subtitle_c_count': {'numerator': 'not_subtitle_c'},
        'corrective_action_component_count': {'numerator': 'corrective_action_component'},
        
        'max_time_to_violation': {'numerator': lambda i: i['max_violation_determined_date'] - i['start_date'], 'func': 'max'},
        
        'state_violation_count': {'numerator': 'violation_state'},
        'epa_violation_count': {'numerator': 'violation_epa'},
        
        'max_time_to_compliance': {'numerator': lambda i: i['max_rtc_date'] - i['max_scheduled_compliance'], 'func': 'max'},
        'avg_time_to_compliance': {'numerator': lambda i: i['max_rtc_date'] - i['max_scheduled_compliance'], 'func': 'mean'},

        # init/comply columns  are indicators?
        'max_diff_fmp_paid': {'numerator': lambda i: i['max_final_monetary_amount'] - i['max_paid_amount'], 'func': 'max'},
        'max_diff_fmp_pmp': {'numerator': lambda i: i['max_final_monetary_amount'] - i['max_proposed_penalty_amount'], 'func': 'max'},
        'avg_paid_amount': {'numerator': 'max_paid_amount', 'func': 'mean'},
        'avg_fmp_amount': {'numerator': 'max_final_monetary_amount', 'func': 'mean'},
        'avg_pmp_amount': {'numerator': 'max_proposed_penalty_amount', 'func': 'mean'},
        
        ## ideas:
        # appeal, violation, enforcement, SEP, monetary penalty: ever, days since last, 
        # disposition status, appeal: time between violation/enforcement
        # what's the best way to deal with the arrays?
        # appeal/SEP: time between initiated and resolved: max, average, min (nonlinear?)
        # SEP: ever defaulted, expenditure amount (max/avg)
        # inspections and violations: time between in the past (max/avg)
        # aggregations: time, state, region, ...

    }
