# get_investigations below returns cesnored investigations for a given date used in investigations_aggregated
import os
import pandas as pd
import itertools

from drain import util
from drain.data import date_censor_sql, ToHDF, FromSQL
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
list_columns = ['violation_type', 'violation_class', 'enforcement_type', 'evaluation_type',
                'focus_area', 'land_type', 'return_to_compliance_qualifier', 'sep_type',
                #'former_citations' ignore former citations for now...
]

class InvestigationsAggregation(SpacetimeAggregation):
    def __init__(self, spacedeltas, dates, **kwargs):
        SpacetimeAggregation.__init__(self, spacedeltas=spacedeltas, dates=dates, 
                prefix='investigations', date_column='start_date', **kwargs)

        if len(self.dates) != 1 and not self.parallel:
            raise ValueError('Currently only able to run one date at a time, try parallel=True')

        if not self.parallel:
            self.inputs = [Investigations(self.dates[0])]

    def get_aggregates(self, date, delta):
        aggregates =  [
            Count(),
            Aggregate('violation', 'any', fname=False),
            Aggregate('formal_enforcement', 'any', fname=False),
            Count('violation', prop=True),
            Count('formal_enforcement', prop=True),
            Count('agency_epa', name='epa', prop=True),
            Count('agency_state', name='state', prop=True),
            Aggregate(lambda i: (date - i.start_date) / day, ['min','max'], 'days_since_evaluation'),
            Aggregate(lambda i: (date - i.violation_determined_date) / day, ['min','max'], 
                    'days_since_violation'),
            Aggregate(lambda i: (date - i.enforcement_action_date) / day, 'min', 
                    'days_since_enforcement'),
            Aggregate(lambda i: (i.violation_determined_date - i.start_date) / day, 'max', 
                    'evaluation_to_violation'),
            Aggregate(lambda i: (i.actual_return_to_compliance_date - 
                    i.violation_determined_date) / day, 
                    ['max','mean'], 'violation_to_rtc'),
            Aggregate(lambda i: (i.actual_return_to_compliance_date - 
                    i.scheduled_compliance_date) / day, 
                    ['max', 'mean'], 'overtime'),
            Aggregate(lambda i: i.final_monetary_amount - i.paid_amount, 
                    'max', 'diff_fmp_paid'),
            Aggregate(lambda i: i.final_monetary_amount - i.proposed_penalty_amount, 
                    'max', 'diff_fmp_mpm'),
            Aggregate(['expenditure_amount', 'proposed_penalty_amount', 
                    'final_monetary_amount', 'paid_amount', 'final_count', 
                    'final_amount'], ['max', 'mean', 'min', 'sum']),
            Aggregate(lambda i: (i.sep_actual_completion_date - 
                    i.sep_scheduled_completion_date) / day, ['max', 'min'], 
                    'time_to_sep_completion'),
            Aggregate(lambda i: (i.sep_defaulted_date - 
                    i.sep_scheduled_completion_date) / day,
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


date_columns = ['evaluation_start_date', 'enforcement_action_date', 
            'violation_determined_date', 'actual_return_to_compliance_date', 
            'scheduled_compliance_date', 'appeal_initiated_date', 'appeal_resolved_date',
            'sep_actual_completion_date', 'sep_defaulted_date', 'sep_scheduled_completion_date']

class Investigations(Step):
    """
    Reads cmecomp3 evaluations into censored investigations
    """
    def __init__(self, date, **kwargs):
        Step.__init__(self, date=date, **kwargs)

        self.inputs = [ToHDF(
            put_args={'cmecomp3':dict(format='t', data_columns=['evaluation_start_date'])}, 
            inputs_mapping=['cmecomp3'], objects_to_ascii=True,
            inputs=[FromSQL(to_str=['citizen_complaint_flag'], query="""
select *,
        violation_type is not null as violation,
        evaluation_agency in ('E','X','C','N') as agency_epa,
        evaluation_agency not in ('E','X','C','N') as agency_state,
        enforcement_type::int between 300 and 799 as formal_enforcement,
        enforcement_agency = 'E' as enforcement_epa,
        enforcement_agency = 'S' as enforcement_state,
        violation_determined_by_agency = 'E' as violation_epa,
        violation_determined_by_agency = 'S' as violation_state,
        corrective_action_component_flag = 'Y' as corrective_action_component,
        citizen_complaint_flag = 'Y' as citizen_complaint,
        multimedia_inspection_flag = 'Y' as multimedia_inspection,
        sampling_flag = 'Y' as sampling,
        not_subtitle_c_flag = 'Y' as not_subtitle_c,
        CASE WHEN violation_type like '%%.%%' 
                THEN substring(violation_type for 3) ELSE null END as violation_class
from rcra.cmecomp3 where handler_id is not null
and (violation_determined_date is null or evaluation_start_date <= violation_determined_date)
""", parse_dates=date_columns, tables='rcra.rcra')]) # because we don't do psql stubs right
        ]
    
    def run(self, cmecomp3):
        df = cmecomp3.select('cmecomp3', where="evaluation_start_date < '%s'" % self.date)
        df.rename(columns={'evaluation_start_date':'start_date', 'handler_id':'rcra_id'}, inplace=True)
        return df
