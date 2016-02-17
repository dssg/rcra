# get_investigations below returns cesnored investigations for a given date used in investigations_aggregated
import os
import pandas as pd
import numpy as np
import itertools

from drain import util, data, aggregate
from drain.data import date_censor_sql, ToHDF, FromSQL
from drain.step import Step
from drain.aggregation import SpacetimeAggregation, SimpleAggregation
from drain.aggregate import Aggregate, Count, aggregate_counts, days

# these are arrays that get concatenated and then counted and proportioned
list_columns = ['violation_type', 'enforcement_type', 'evaluation_type',
                'focus_area', 'land_type', 'return_to_compliance_qualifier', 'sep_type',
                #'former_citations' ignore former citations for now...
]

outcomes = ['violation', 'violation_epa', 'violation_state', 
            'formal_enforcement', 'enforcement_state', 
            'enforcement_epa', 'formal_enforcement_state', 
            'formal_enforcement_epa']

amounts = ['final_monetary_amount', 'paid_amount', 'proposed_penalty_amount', 
            'expenditure_amount', 'final_count', 'final_amount']

flags = ['corrective_action_component', 'citizen_complaint', 
        'multimedia_inspection', 'sampling', 'not_subtitle_c']

class InvestigationsAggregation(SpacetimeAggregation):
    def __init__(self, spacedeltas, dates, **kwargs):
        SpacetimeAggregation.__init__(self, spacedeltas=spacedeltas, 
                dates=dates, prefix='investigations',
                date_column='start_date', **kwargs)

        if len(self.dates) != 1 and not self.parallel:
            raise ValueError('Currently only able to run one date at a time, try parallel=True')

        if not self.parallel:
            self.inputs = [Investigations(self.dates[0], target=True)]

    def get_aggregates(self, date, delta):
        return  [
            Count(),
            # agencies
            Aggregate(['agency_epa', 'agency_state'], 'any', fname=False),
            Count(['agency_epa', 'agency_state'], prop=True),

            # outcomes
            Aggregate(outcomes + flags, 'any', fname=False),
            Count(outcomes + flags, prop=True),

            Aggregate([days('min_' + c, date) for c in date_columns], 'min', 
                name=[c + '_days' for c in date_columns]),
            Aggregate([days('max_' + c, date) for c in date_columns], 'max', 
                name=[c + '_days' for c in date_columns]),
            Aggregate(days('min_violation_determined_date', 'start_date'), ['min', 'mean', 'max'], 
                    'evaluation_to_violation'),
            Aggregate(days('min_violation_determined_date', 'max_actual_return_to_compliance_date'),
                    ['min', 'mean', 'max'], 'violation_to_rtc'),
            Aggregate(days('min_scheduled_compliance_date', 'max_actual_return_to_compliance_date'),
                    ['min', 'mean', 'max'], 'overtime'),
            Aggregate(lambda i: i.final_monetary_amount - i.paid_amount, 
                    ['min', 'mean', 'max'], 'diff_fmp_paid'),
            Aggregate(lambda i: i.final_monetary_amount - i.proposed_penalty_amount, 
                    ['min', 'mean', 'max'], 'diff_fmp_mpm'),
            Aggregate(amounts , ['max', 'mean', 'min', 'sum']),
            Aggregate(days('min_sep_scheduled_completion_date', 'max_sep_actual_completion_date'), 
                    ['max', 'min'], 'sep_completion_overtime'),
            Aggregate(days('min_sep_defaulted_date', 'max_sep_scheduled_completion_date'),
                    ['max', 'min'], 'sep_default_to_completion'),
            #Aggregate(list_columns, aggregate_counts, fname=False)
        ]

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

date_columns = censor_dates.keys() + \
        ['scheduled_compliance_date', 'sep_scheduled_completion_date']

parse_dates = ['min_' + c for c in date_columns] + \
               ['max_' + c for c in date_columns] + ['start_date']

class Investigations(Step):
    """
    Reads cmecomp3 evaluations into censored investigations
    """
    def __init__(self, date, **kwargs):
        Step.__init__(self, date=date, **kwargs)
        self.sql_filename = os.path.join(os.path.dirname(os.path.abspath(__file__)), 
                'investigations_censored.sql')
        psql_dir = os.environ['PSQL_DIR']
        self.dependencies = [os.path.join(psql_dir, 'rcra/rcra'), 
                os.path.join(psql_dir, 'output/region_states'), self.sql_filename]
    
    def run(self):
        #db = util.create_db()
        engine = util.create_engine()
        with open(self.sql_filename, 'r') as sql_file:
            censored = {}
            for d in censor_dates:
                censored[d] = date_censor_sql(d, self.date, d)
                censored.update({c: date_censor_sql(d, self.date, c) for c in censor_dates[d]})

            sql = sql_file.read()
            sql = sql.format(date=self.date, **censored)
            return pd.read_sql(sql, engine, parse_dates=parse_dates)
            #return db.read_sql(sql, parse_dates=date_columns)
