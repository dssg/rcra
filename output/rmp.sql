DROP TABLE IF EXISTS output.rmp;

CREATE TABLE output.rmp AS (
   
	    select facility_uin as rmp_id,
	    pgm_sys_id as rcra_id,

	    bool_or(activity_status_desc = 'Achieved') as activity_status_achieved,
	    bool_or(activity_status_desc = 'Active') as activity_status_active,
	    bool_or(comp_monitor_category_desc = 'Comprehensive') as comp_monitor_comprehensive,
	    bool_or(observed_deficiency_flag = 't') as observed_deficiency,
	    bool_or(communicate_deficiency_flag = 't') as communicate_deficiency,
	    bool_or(facility_action_flag = 't') as facility_action,
	    bool_or(general_comp_assistance_flag = 't') as general_comp_assistance,
	    bool_or(specific_comp_assistance_flag = 't') as specific_comp_assistance,
	    actual_end_date 

	    from rmp.rmp_inspections a
	    left join frs.program_links b
	    on (a.facility_uin = b.registry_id)

	    where b.pgm_sys_acrnm = 'RCRAINFO'
	    and b.pgm_sys_id is not null
	    and a.actual_end_date is not null


	    --- there can be multiple RCRA IDs for one RMP ID
	    --- and multiple observations for one date	    
	    group by rcra_id, rmp_id, actual_end_date);
