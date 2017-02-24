# get_investigations below returns cesnored investigations for a given date used in investigations_aggregated
import os
import pandas as pd
import numpy as np
import itertools

from drain import util, data, aggregate
from drain.data import date_censor_sql, ToHDF, FromSQL, Revise, Merge, BinarizeSets
from drain.step import Step
from drain.aggregation import SpacetimeAggregation, SimpleAggregation
from drain.aggregate import Aggregate, Count, aggregate_counts, days

from . import investigations_sql, facilities

# these are arrays that get concatenated and then counted and proportioned
#list_columns = ['violation_type', 'enforcement_type', 'evaluation_type',
#                'focus_area', 'land_type', 'return_to_compliance_qualifier', 'sep_type',
                #'former_citations' ignore former citations for now...
#]

date_columns = investigations_sql.date_columns
parse_dates = ['min_' + c for c in date_columns] + \
              ['max_' + c for c in date_columns] + ['start_date']

outcomes = ['violation', 'violation_epa', 'violation_state', 
            'formal_enforcement', 'enforcement_state', 
            'enforcement_epa', 'formal_enforcement_state', 
            'formal_enforcement_epa']

amounts = ['final_monetary_amount', 'paid_amount', 'proposed_penalty_amount', 
            'expenditure_amount', 'final_count', 'final_amount']

flags = ['corrective_action_component', 'citizen_complaint', 
         'multimedia_inspection', 'sampling', 'not_subtitle_c']

EVALUATION_TYPES = ['CEI', 'FCI', 'NRR', 'CSE', 'SNY', 'FRR', 'FUI', 'SNN', 
                    'CAV', 'CDI', 'GME', 'FSD', 'OAM', 'CAC', 'NIR']

class InvestigationsAggregation(SpacetimeAggregation):
    def __init__(self, spacedeltas, dates, parallel=True):
        SpacetimeAggregation.__init__(self, spacedeltas=spacedeltas, 
                dates=dates, prefix='investigations',
                date_column='start_date', parallel=parallel)

        if not parallel:
            sql = investigations_sql.get_sql(self.dates[0])
            i = Revise(sql=sql, 
                    id_column = ['rcra_id', 'start_date'],
                    source_id_column = ['handler_id', 'evaluation_start_date'],
                    max_date_column = 'max_date',
                    min_date_column = 'start_date',
                    date_column = 'evaluation_start_date',
                    date = self.dates[0],
                    from_sql_args={'parse_dates':parse_dates})
            for j in i.inputs: j.target = True
            i = BinarizeSets(inputs=[i], cast=True,
                             columns={'evaluation_types':EVALUATION_TYPES})
            self.inputs = [Merge(inputs=[i, facilities], on='rcra_id')]

    def get_aggregates(self, date, delta):
        aggregates =  [
            Count(),
            # agencies
            Aggregate(['agency_epa', 'agency_state'], 'any', fname=False),
            Count(['agency_epa', 'agency_state'], prop=True),

            # outcomes
            Aggregate(outcomes + flags, 'any', fname=False),
            Count(outcomes + flags, prop=True),

            Aggregate(days('start_date', date), 'max', name='start_date_days'),
            Aggregate([days('max_' + c, date) for c in date_columns], 'max', 
                name=[c + '_days' for c in date_columns]),
            Count([lambda i,c=c: i['min_' + c].notnull() for c in date_columns], 
                  name=date_columns, prop=True),
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
            Count(['evaluation_types_' + t for t in EVALUATION_TYPES], prop=True)
            #Aggregate(list_columns, aggregate_counts, fname=False)
        ]

        if delta == 'all':
            aggregates.extend([
                Aggregate([days('min_' + c, date) for c in date_columns], 'min', 
                    name=[c + '_days' for c in date_columns]),
                Aggregate(days('start_date', date), 'min', name='start_date_days'),
            ])
           
        return aggregates 
