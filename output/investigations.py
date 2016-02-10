# get_investigations below returns cesnored investigations for a given date used in investigations_aggregated
import os
import pandas as pd
import itertools

from drain import util
from drain.data import date_censor_sql
from drain.step import Step
from drain.util import day
from drain.aggregation import SpacetimeAggregation
from drain.aggregate import Aggregate, Count, aggregate_counts

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

class InvestigationsAggregation(SpacetimeAggregation):
    def __init__(self, spacedeltas, dates, **kwargs):
        SpacetimeAggregation.__init__(self, spacedeltas=spacedeltas, dates=dates, 
                prefix='investigations', date_column='start_date', **kwargs)

        if len(self.dates) != 1 and not self.parallel:
            raise ValueError('Currently only able to run one date at a time, try parallel=True')

        if not self.parallel:
            self.inputs = [Investigations(self.dates[0], target=True)]

    def get_aggregates(self, date, delta):
        aggregates =  [
            Count(),
            Count('agency_epa', name='epa', prop=True),
            Count('agency_state', name='state', prop=True),
            Aggregate(lambda i: (date - i.start_date) / day, ['min','max'], 'days_since_evaluation'),
            Aggregate(lambda i: (date - i.max_violation_determined_date) / day, ['min','max'], 
                    'days_since_violation'),
            Aggregate(lambda i: (date - i.max_formal_enforcement_date) / day, 'min', 
                    'days_since_enforcement'),
            Aggregate(lambda i: (i.max_violation_determined_date - i.start_date) / day, 'max', 
                    'evaluation_to_violation'),
            Aggregate(lambda i: (i.max_rtc_date - i.max_violation_determined_date) / day, 
                    ['max','mean'], 'violation_to_rtc'),
            Aggregate(lambda i: (i.max_rtc_date - i.max_scheduled_compliance_date) / day, 
                    ['max', 'mean'], 'overtime'),
            Aggregate(lambda i: i.max_final_monetary_amount - i.max_paid_amount, 
                    'max', 'diff_fmp_paid'),
            Aggregate(lambda i: i.max_final_monetary_amount - i.max_proposed_penalty_amount, 
                    'max', 'diff_fmp_mpm'),
            Aggregate('max_paid_amount', ['max', 'mean', 'min']),
            Aggregate('max_final_monetary_amount', 'mean'),
            Aggregate('max_proposed_penalty_amount', 'mean'),
            Aggregate('max_expenditure_amount', 'max'),
            Aggregate(lambda i: (i.max_sep_actual_completion_date - 
                    i.max_sep_scheduled_completion_date) / day, ['max', 'min'], 
                    'time_to_sep_completion'),
            Aggregate(lambda i: (i.min_sep_defaulted_date - 
                    i.max_sep_scheduled_completion_date) / day,
                    ['max', 'min'], 'time_to_sep_default'),
            Aggregate(list_columns, aggregate_counts, fname=False),
            Count(bool_columns, prop=True)
        ]
        
        return aggregates

columns_to_censor = {
    'enforcement_action_date': ['enforcement_type', 'enforcement_action_date', 
            'enforcement_agency'],
    'actual_return_to_compliance_date' : ['actual_return_to_compliance_date', 
            'return_to_compliance_qualifier'],
    'appeal_initiated_date' : ['appeal_initiated_date'],
    'appeal_resolved_date' : ['appeal_resolved_date'],
    'sep_actual_completion_date' : ['sep_actual_completion_date'],
    'sep_defaulted_date' : ['sep_defaulted_date'],
}


date_columns = ['start_date'] + list(itertools.chain(*(['min_%s' % d, 'max_%s' % d] for d in [
            'formal_enforcement_date', 'violation_determined_date', 'rtc_date', 
            'scheduled_compliance_date', 'appeal_initiated_date', 'appeal_resolved_date',
            'sep_actual_completion_date', 'sep_defaulted_date', 'sep_scheduled_completion_date'])))

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
            for d in columns_to_censor:
                censored.update({c: date_censor_sql(d, self.date, c) for c in columns_to_censor[d]})

            sql = sql_file.read().format(date=self.date, **censored)
            return pd.read_sql(sql, engine, parse_dates=date_columns)
            return db.read_sql(sql, parse_dates=date_columns)
