import pandas as pd
import numpy as np
import sys
import datetime

from drain import util
from drain.aggregate import aggregate
from drain.util import PgSQLDatabase,prefix_columns

INVESTIGATION_COLUMNS = {
        'violation_types': {'numerator': 'violation_types', 'func': aggregate_list},
        'evaluation_types': {'numerator': 'evaluation_types', 'func': aggregate_list},
        'focus_areas': {'numerator': 'focus_areas', 'func': aggregate_list},
        'land_types': {'numerator': 'land_types', 'func': aggregate_list},
        'former_citations': {'numerator': 'former_citations', 'func': aggregate_list},
        'rtc_qualifiers': {'numerator': 'rtc_qualifiers', 'func': aggregate_list},
        'enforcement_types': {'numerator': 'enforcement_types', 'func': aggregate_list},
        
        'inspection_count': {'numerator': 1},
        'days_since_last_inspection': {'numerator': lambda i: (today - i['start_date']) / day, 'func': 'min'},

        'days_since_last_violation': {'numerator': lambda i: (today - i['max_violation_determined_date']) / day, 'func': 'min'},
        
        # Booleans sum to True/False
        'citizen_complaints': {'numerator': 'citizen_complaint'},
        'multimedia_inspections': {'numerator': 'multimedia_inspection'},
        'sampling_count': {'numerator': 'sampling'},
        'not_subtitle_c_count': {'numerator': 'not_subtitle_c'},
        'corrective_action_component_count': {'numerator': 'corrective_action_component'},
        
        'max_time_to_violation': {'numerator': lambda i: (i['max_violation_determined_date'] - i['start_date']) / day, 'func': 'max'},
        'max_time_violation_to_rtc': {'numerator': lambda i: (i['max_rtc_date'] - i['max_violation_determined_date']) / day, 'func': 'max'},
        'avg_time_violation_to_rtc': {'numerator': lambda i: (i['max_rtc_date'] - i['max_violation_determined_date']) / day, 'func': 'mean'},
        
        'state_violation_count': {'numerator': 'violation_state'},
        'epa_violation_count': {'numerator': 'violation_epa'},
        'state_enforcement_count': {'numerator': 'enforcement_state'},
        'epa_enforcement_count': {'numerator': 'enforcement_epa'},
        
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
        'days_since_last_enforcement': {'numerator': lambda i: (today - i['max_enforcement_action_date']) / day, 'func': 'min'},
        

        ## ideas:
        # appeal, violation, enforcement, SEP, monetary penalty: ever, days since last, 
        # appeal: time between violation/enforcement
        # what's the best way to deal with the arrays? evers?
        # appeal/SEP: time between initiated and resolved: max, average, min (nonlinear?)
        # SEP: ever defaulted, expenditure amount (max/avg)
        # inspections and violations: time between in the past - comparing two rows of same column (max/avg)
       
       # aggregations: time, state, region, ...

    }
