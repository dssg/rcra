---
--- All entries must have RCRA ID and evaluation start date (make unique ID)
--- Do not consider four types of (follow-up) inspections 
--- agency_epa column for evaluating performance on EPA vs state evaluations
---

drop table if exists output.evaluations;

create table output.evaluations as
select handler_id as rcra_id, evaluation_start_date as start_date, state,
    found_violation_flag = 'Y' as violation,
    evaluation_agency in ('E','X','C','N') as agency_epa,
    coalesce(enforcement_type::int between 300 and 799, false) as formal_enforcement,

    citizen_complaint_flag = 'Y' as citizen_complaint,
    region,
    multimedia_inspection_flag = 'Y' as multimedia_inspection,
    sampling_flag = 'Y' as sampling,
    not_subtitle_c_flag = 'Y' as not_subtitle_c,
    
    evaluation_type,
    focus_area,
    land_type,
    violation_type,
    (CASE WHEN violation_type like '%.%' THEN substring(violation_type for 3) ELSE null END) as violation_class,
    
    violation_determined_by_agency = 'E' as violation_epa,
    violation_determined_by_agency = 'S' as violation_state,
    
    former_citation,
    violation_determined_date,
    actual_return_to_compliance_date,
    
    return_to_compliance_qualifier,
    scheduled_compliance_date,
    
    enforcement_type,
    enforcement_action_date,
    enforcement_agency = 'E' as enforcement_epa,
    enforcement_agency = 'S' as enforcement_state,
    corrective_action_component_flag = 'Y' as corrective_action_component,
    
    appeal_initiated_date,
    appeal_resolved_date,
    expenditure_amount,
    sep_scheduled_completion_date,
    sep_actual_completion_date,
    sep_defaulted_date,
    
    sep_type,
    proposed_penalty_amount,
    final_monetary_amount,
    paid_amount

from rcra.cmecomp3 
   where handler_id is not null 
   and evaluation_start_date is not null
   and evaluation_type not in ('FUI','SNN','SNY','FSD')
   and (violation_determined_date is null or evaluation_start_date <= violation_determined_date);


-- Add unique ID for RCRA ID & evaluation start date pairs
ALTER TABLE output.evaluations ADD COLUMN evaluation_id SERIAL PRIMARY KEY;
