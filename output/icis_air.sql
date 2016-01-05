DROP TABLE IF EXISTS output.icis_air;

CREATE TABLE output.icis_air as (

       with facilities as (
       	    select b.pgm_sys_id as rcra_id,
	    	   a.pgm_sys_id as icis_id
		   
		   from air.air_facilities a
		   left join frs.program_links b using (registry_id)
		   where b.pgm_sys_acrnm = 'RCRAINFO'),

	fces_pces as (
		  select pgm_sys_id as icis_id,
		  	 state_epa_flag as fces_pces_agency,
		  	 comp_monitor_type_code as fces_pces_comp_monitor_type_code,
			 actual_end_date as fces_pces_date
			 from air.air_fces_pces),

	stack_tests as (
		    select pgm_sys_id as icis_id,
		    	   state_epa_flag as stack_test_agency,
			   air_stack_test_status_code as stack_test_status_code,
			   actual_end_date as stack_test_date
			   from air.air_stack_tests),

	titlev_certs as (
		     select pgm_sys_id as icis_id,
		     state_epa_flag as titlev_cert_agency,
		     facility_rpt_deviation_flag = 't' as titlev_cert_rpt_deviation,
		     actual_end_date as titlev_cert_date
		     from air.air_titlev_certs),

	formal_actions as (
		       select pgm_sys_id as icis_id,
		       state_epa_flag as formal_action_agency,
		       activity_type_code = 'JDC' as formal_action_judicial,
		       penalty_amount as formal_action_penalty_amt,
		       settlement_entered_date as formal_action_date
		       from air.air_formal_actions),
		       
	informal_actions as (
			 select pgm_sys_id as icis_id,
			 state_epa_flag as informal_action_agency,
			 enf_type_code as informal_action_enf_type,
			 achieved_date as informal_action_date
			 from air.air_informal_actions),

	hpv_history as (
		    select pgm_sys_id as icis_id,
		    agency_type_desc as hpv_agency,
		    enf_response_policy_code as hpv_policy_code,
		    hpv_dayzero_date, hpv_resolved_date
		    from air.air_hpv_history)


		    select * from facilities
		    left join fces_pces using (icis_id)
		    left join stack_tests using (icis_id)
		    left join titlev_certs using (icis_id)
		    left join formal_actions using (icis_id)
		    left join informal_actions using (icis_id)
		    left join hpv_history using (icis_id)
		    where icis_id is not null

);
