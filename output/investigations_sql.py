from drain.util import read_file
from drain.data import date_censor_sql
import os

censor_dates = {
    'violation_determined_date': ['violation_determined_by_agency',
            'violation_type', 'violation_short_description',
            'violation_responsible_agency',
            'violation_activity_location', 'violation_sequence_number'],
    'enforcement_action_date': ['enforcement_type',
            'enforcement_agency', 'enforcement_activity_location',
            'enforcement_identifier', 'enforcement_agency',
            'proposed_penalty_amount', 'final_monetary_amount',
            'paid_amount', 'final_count', 'final_amount',
            'expenditure_amount', 'sep_scheduled_compliance_date',
            'sep_scheduled_completion_date'],
    'actual_return_to_compliance_date' : [
            'return_to_compliance_qualifier'],
    'appeal_initiated_date' : [],
    'appeal_resolved_date' : [],
    'sep_actual_completion_date' : [],
    'sep_defaulted_date' : [],
}

# extra dates are in the enforcement_action_date censor list above
date_columns = list(censor_dates.keys()) + \
        ['scheduled_compliance_date', 'sep_scheduled_completion_date'] 

def get_sql(date):
    """Performs date censoring. Outputs SQL code with only the required dates for an analysis.

    Args: 
        date: The date on which the censoring occurs

    Returns: 
        SQL command with correct selection dates  
    """
    sql = read_file(os.path.join(os.path.dirname(os.path.abspath(__file__)), 'investigations.sql'))
    format_vars = {}
    for d in censor_dates:
        format_vars[d] = date_censor_sql(d, date)
        format_vars.update({c: date_censor_sql(d, date, c) for c in censor_dates[d]})

    format_vars['dates'] = str.join(', ', date_columns + ['evaluation_start_date'])
    return sql.format(**format_vars)

if __name__ == '__main__':
    print(get_sql(None))
