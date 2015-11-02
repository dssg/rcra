---
--- All entries must have RCRA ID and evaluation start date (make unique ID)
--- Do not consider four types of (follow-up) inspections 
--- agency_epa column for evaluating performance on EPA vs state evaluations
---

drop table if exists output.evaluations;

create table output.evaluations as
select handler_id as rcra_id, evaluation_start_date start_date, state,
    bool_or(found_violation_flag = 'Y') as violation,
    count(*) as inspection_count,
    count(case when found_violation_flag = 'Y' then 1 else null end) as violation_count
,
    bool_or(evaluation_agency in ('E','X','C','N')) as agency_epa,
    coalesce(bool_or(enforcement_type::int between 300 and 799), false) formal_enforcement,
    
    bool_or(citizen_complaint_flag = 'Y') as citizen_complaint,
    min(region) as region,
    bool_or(multimedia_inspection_flag = 'Y') as multimedia_inspection,
    bool_or(sampling_flag = 'Y') as sampling,
    bool_or(not_subtitle_c_flag = 'Y') as not_subtitle_c,
    
    array_remove(array_agg(evaluation_type), null) as evaluation_types,
    array_remove(array_agg(focus_area), null) as focus_areas,
    array_remove(array_agg(land_type), null) as land_types,
    array_remove(array_agg(violation_type), null) as violation_types,
    array_remove(array_agg(CASE WHEN violation_type like '%.%' THEN substring(violation_type for 3) ELSE null END), null) as violation_classes,
    
    bool_or(violation_determined_by_agency = 'E') as violation_epa,
    bool_or(violation_determined_by_agency = 'S') as violation_state,
    
    array_remove(array_agg(former_citation), null) as former_citations,
    min(violation_determined_date) as min_violation_determined_date,
    max(violation_determined_date) as max_violation_determined_date,
    min(actual_return_to_compliance_date) as min_rtc_date,
    max(actual_return_to_compliance_date) as max_rtc_date,
    
    array_remove(array_agg(return_to_compliance_qualifier), null) as rtc_qualifiers,
    min(scheduled_compliance_date) as min_scheduled_compliance_date,
    max(scheduled_compliance_date) as max_scheduled_compliance_date,
    
    array_remove(array_agg(enforcement_type), null) as enforcement_types,
    min(enforcement_action_date) as min_enforcement_action_date,
    max(enforcement_action_date) as max_enforcement_action_date,
    bool_or(enforcement_agency = 'E') as enforcement_epa,
    bool_or(enforcement_agency = 'S') as enforcement_state,
    bool_or(corrective_action_component_flag = 'Y') as corrective_action_component,
    
    min(appeal_initiated_date) as min_appeal_initiated_date,
    max(appeal_initiated_date) as max_appeal_initiated_date,
    min(appeal_resolved_date) as min_appeal_resolved_date,
    max(appeal_resolved_date) as max_appeal_resolved_date,
    min(expenditure_amount) as min_expenditure_amount,
    max(expenditure_amount) as max_expenditure_amount,
    min(sep_scheduled_completion_date) as min_sep_scheduled_completion_date,
    max(sep_scheduled_completion_date) as max_sep_scheduled_completion_date,
    min(sep_actual_completion_date) as min_sep_actual_completion_date,
    max(sep_actual_completion_date) as max_sep_actual_completion_date,
    min(sep_defaulted_date) as min_sep_defaulted_date,
    max(sep_defaulted_date) as max_sep_defaulted_date,
    
    array_remove(array_agg(sep_type), null) as sep_types,
    max(proposed_penalty_amount) as max_proposed_penalty_amount,
    max(final_monetary_amount) as max_final_monetary_amount,
    max(paid_amount) as max_paid_amount

from rcra.cmecomp3 
   where handler_id is not null 
   and evaluation_start_date is not null
   and evaluation_type not in ('FUI','SNN','SNY','FSD')
   and (violation_determined_date is null or evaluation_start_date <= violation_determined_date)
group by 1,2,3;

ALTER TABLE output.evaluations ADD UNIQUE (rcra_id, start_date);

-- Add unique ID for RCRA ID & evaluation start date pairs
ALTER TABLE output.evaluations ADD COLUMN evaluation_id SERIAL PRIMARY KEY;
