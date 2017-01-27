DROP TABLE IF EXISTS output.icis_fec;

CREATE TABLE output.icis_fec as (

with facilities as (
	select b.pgm_sys_id as rcra_id,
	a.registry_id, a.activity_id
	from fec.fec_facilities a
	join frs.program_links b using (registry_id)
        join output.facilities on b.pgm_sys_id = rcra_id
	where b.pgm_sys_acrnm = 'RCRAINFO'),

enforcements as (
	select activity_id, activity_status_date,
	activity_type_code,
	lead = 'EPA' as lead_agency_epa, 
	total_comp_action_amt,
	total_cost_recovery_amt,
	total_penalty_assessed_amt,
	hq_division as epa_division,
	multimedia_flag = 'Y' as multimedia_flag
	from fec.fec_enforcements),

violation_types as (
	select activity_id, 
		   count(distinct violation_type_code) as violation_type_count
	from fec.fec_violations
	group by activity_id),

enforcement_types as (
	select activity_id, 
		   count(distinct enf_type_code) as enf_type_count
	from fec.fec_enforcement_type
	group by activity_id),

relief_sought as (
	select cast(activity_id as varchar),
		   count(distinct relief_code) as relief_type_count
	from fec.fec_relief_sought
	group by activity_id),

penalties as (
	select activity_id, 
		   fed_penalty, st_lcl_penalty, total_sep, 
	   compliance_action_cost, federal_cost_recovery_amt,
	   state_local_cost_recovery_amt 
	from fec.fec_penalties)    

select * from facilities
left join enforcements using (activity_id)
left join violation_types using (activity_id)
left join enforcement_types using (activity_id)
left join relief_sought using (activity_id)
left join penalties using (activity_id)
where activity_id is not null
);
