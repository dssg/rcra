with investigations as (
select handler_id as rcra_id, 
    evaluation_start_date start_date,
    count(*) as evaluation_count,
    
    bool_or(evaluation_agency in ('E','X','C','N')) as agency_epa,
    bool_and(evaluation_agency not in ('E','X','C','N')) as agency_state,
    
    bool_or({violation_type} is not null) as violation,
    bool_or({enforcement_type} is not null) as enforcement,
    coalesce(bool_or({enforcement_type}::int between 300 and 799), false) formal_enforcement,

    min({enforcement_action_date}) as min_enforcement_action_date,
    max({enforcement_action_date}) as max_enforcement_action_date,

    bool_or({enforcement_agency} = 'E') as enforcement_epa,
    bool_or({enforcement_agency} = 'S') as enforcement_state,
    
    bool_or(corrective_action_component_flag = 'Y') as corrective_action_component,
    bool_or(citizen_complaint_flag = 'Y') as citizen_complaint,
    bool_or(multimedia_inspection_flag = 'Y') as multimedia_inspection,
    bool_or(sampling_flag = 'Y') as sampling,
    bool_or(not_subtitle_c_flag = 'Y') as not_subtitle_c,
    
    array_remove(array_agg(evaluation_type), null) as evaluation_types,
    array_remove(array_agg({enforcement_type}), null) as enforcement_types,
    array_remove(array_agg(focus_area), null) as focus_areas,
    array_remove(array_agg(land_type), null) as land_types,
    array_remove(array_agg(violation_type), null) as violation_types,
    
    bool_or({violation_determined_by_agency} = 'E') as violation_epa,
    bool_or({violation_determined_by_agency} = 'S') as violation_state,
    
    array_remove(array_agg(former_citation), null) as former_citations,
    
    min({violation_determined_date}) as min_violation_determined_date,
    max({violation_determined_date}) as max_violation_determined_date,
    
    min({actual_return_to_compliance_date}) as min_actual_return_to_compliance_date,
    max({actual_return_to_compliance_date}) as max_actual_return_to_compliance_date,

    array_remove(array_agg({return_to_compliance_qualifier}), null) as rtc_qualifiers,
    
    min(scheduled_compliance_date) as min_scheduled_compliance_date,
    max(scheduled_compliance_date) as max_scheduled_compliance_date,
    
    min({sep_actual_completion_date}) as min_sep_actual_completion_date,
    max({sep_actual_completion_date}) as max_sep_actual_completion_date,

    min(sep_scheduled_completion_date) as min_sep_scheduled_completion_date,
    max(sep_scheduled_completion_date) as max_sep_scheduled_completion_date,
    
    min({sep_defaulted_date}) as min_sep_defaulted_date,
    max({sep_defaulted_date}) as max_sep_defaulted_date,

    min({appeal_initiated_date}) as min_appeal_initiated_date,
    max({appeal_initiated_date}) as max_appeal_initiated_date,
    bool_or({appeal_initiated_date} is not null) as appeal_iniated,

    min({appeal_resolved_date}) as min_appeal_resolved_date,
    max({appeal_resolved_date}) as max_appeal_resolved_date,
    bool_or({appeal_resolved_date} is not null) as appeal_resolved,
    
    array_remove(array_agg(sep_type), null) as sep_types,
    
    max({proposed_penalty_amount}) as proposed_penalty_amount,
    max({final_monetary_amount}) as final_monetary_amount,
    max({paid_amount}) as paid_amount,
    max({expenditure_amount}) as expenditure_amount,
    max({final_count}) as final_count,
    max({final_amount}) as final_amount

from rcra.cmecomp3 
   where handler_id is not null 
   and evaluation_start_date < '{date}'
   and (violation_determined_date is null or evaluation_start_date <= violation_determined_date)
group by 1,2)

select *,
    formal_enforcement and enforcement_state as formal_enforcement_state,
    formal_enforcement and enforcement_epa as formal_enforcement_epa
 from investigations
left join output.region_states rs on substring(rcra_id for 2) = rs.state
