DROP TABLE IF EXISTS output.icis_npdes;

CREATE TABLE output.icis_npdes as (

with facilities as (
       select b.pgm_sys_id as rcra_id,
              a.npdes_id
              from npdes.icis_facilities a
              left join frs.program_links b
              on a.facility_uin = b.registry_id
              where b.pgm_sys_acrnm = 'RCRAINFO'),

	      permits as (
	      select external_permit_nmbr as npdes_id,
	      	     facility_type_indicator as permit_fac_type,
		     major_minor_status_flag = 'M' as permit_major_status,
		     permit_status_code, permit_type_code,
		     total_design_flow_nmbr as permit_total_design_flow,
		     actual_average_flow_nmbr as permit_actual_avg_flow,
		     effective_date as permit_effective_date,
		     expiration_date as permit_expiration_date,
		     termination_date as permit_termination_date
	      from npdes.icis_permits
	      where effective_date is not null),

	      inspections as (
	      select npdes_id, bool_or(state_epa_flag = 'E') as inspection_epa,
	      	      bool_or(state_epa_flag = 'S') as inspection_state,
	      	      array_agg(activity_outcome_desc) as inspection_outcome,
	      	      actual_end_date as inspection_end_date
	      from npdes.npdes_inspections
	      where actual_end_date is not null 
	      group by npdes_id, actual_end_date
	      ),

	      formal_actions as (
	      select npdes_id, activity_type_code as formal_action_activity_type,
	      	     agency as formal_action_agency, fed_penalty_assessed_amt as formal_action_fed_penalty_assessed,
	      	     state_local_penalty_amt as formal_action_state_local_penalty, settlement_entered_date as formal_action_settlement_entered_date
	      from npdes.npdes_formal_enforcement_actions
	      where settlement_entered_date is not null),

	      informal_actions as (
	      select npdes_id,
	      	     agency as informal_action_agency,
	      	     achieved_date as informal_action_achieved_date
	      from npdes.npdes_informal_enforcement_actions
	      where achieved_date is not null) 


	select * from facilities
	left join permits using (npdes_id)
	left join inspections using (npdes_id)
	left join formal_actions using (npdes_id)
	left join informal_actions using (npdes_id)
	where npdes_id is not null
	);








