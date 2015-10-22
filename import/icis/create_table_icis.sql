CREATE SCHEMA IF NOT EXISTS icis;
 
---- ICIS NPDES (npdes_downloads.zip)
DROP TABLE IF EXISTS icis.npdes_facilities;
 
CREATE TABLE icis.npdes_facilities (
	icis_facility_interest_id BIGINT NOT NULL, 
	npdes_id VARCHAR(9) NOT NULL, 
	facility_uin BIGINT, 
	facility_type_code VARCHAR(4), 
	facility_name VARCHAR(80), 
	location_address VARCHAR(50), 
	supplemental_address_text VARCHAR(50), 
	city VARCHAR(51), 
	county_code VARCHAR(5), 
	state_code VARCHAR(4), 
	zip VARCHAR(14), 
	geocode_latitude FLOAT, 
	geocode_longitude FLOAT, 
	impaired_waters VARCHAR(16)
);

DROP TABLE IF EXISTS icis.npdes_cs_violations;

CREATE TABLE icis.npdes_cs_violations (
	npdes_id VARCHAR(9) NOT NULL, 
	npdes_violation_id BIGINT NOT NULL, 
	violation_type_code VARCHAR(1) NOT NULL, 
	comp_schedule_event_id BIGINT NOT NULL, 
	comp_schedule_nmbr INTEGER NOT NULL, 
	violation_code VARCHAR(3) NOT NULL, 
	violation_desc VARCHAR(42) NOT NULL, 
	schedule_event_code VARCHAR(5) NOT NULL, 
	schedule_event_desc VARCHAR(71) NOT NULL, 
	schedule_date DATE NOT NULL, 
	actual_date DATE, 
	rnc_detection_code VARCHAR(4), 
	rnc_detection_desc VARCHAR(34), 
	rnc_detection_date DATE, 
	rnc_resolution_code VARCHAR(4), 
	rnc_resolution_desc VARCHAR(80), 
	rnc_resolution_date DATE
);

DROP TABLE IF EXISTS icis.npdes_formal_enforcement_actions;

CREATE TABLE icis.npdes_formal_enforcement_actions (
	npdes_id VARCHAR(9) NOT NULL, 
	enf_identifier VARCHAR(20) NOT NULL, 
	activity_id BIGINT NOT NULL, 
	activity_type_code VARCHAR(3) NOT NULL, 
	enf_type_code VARCHAR(7) NOT NULL, 
	enf_type_desc VARCHAR(91) NOT NULL, 
	agency VARCHAR(5) NOT NULL, 
	settlement_entered_date DATE, 
	fed_penalty_assessed_amt FLOAT, 
	state_local_penalty_amt FLOAT
);

DROP TABLE IF EXISTS icis.npdes_informal_enforcement_actions;

CREATE TABLE icis.npdes_informal_enforcement_actions (
	npdes_id VARCHAR(9) NOT NULL, 
	registry_id VARCHAR(12) NOT NULL, 
	agency VARCHAR(5) NOT NULL, 
	activity_type_code VARCHAR(3) NOT NULL, 
	activity_type_desc VARCHAR(25) NOT NULL, 
	enf_type_code VARCHAR(5) NOT NULL, 
	enf_type_desc VARCHAR(35) NOT NULL, 
	achieved_date DATE, 
	enf_identifier VARCHAR(19) NOT NULL
);

DROP TABLE IF EXISTS icis.npdes_inspections;

CREATE TABLE icis.npdes_inspections (
	registry_id VARCHAR(12) NOT NULL, 
	npdes_id VARCHAR(9) NOT NULL, 
	activity_id BIGINT NOT NULL, 
	activity_type_code VARCHAR(3) NOT NULL, 
	comp_monitor_type_code VARCHAR(3) NOT NULL, 
	comp_monitor_type_desc VARCHAR NOT NULL, 
	state_epa_flag VARCHAR(1) NOT NULL, 
	actual_begin_date DATE, 
	actual_end_date DATE, 
	activity_outcome_code INTEGER, 
	activity_outcome_desc VARCHAR(45)
);

DROP TABLE IF EXISTS icis.npdes_naics;

CREATE TABLE icis.npdes_naics (
	npdes_id VARCHAR(9) NOT NULL, 
	naics_code INTEGER NOT NULL, 
	naics_desc VARCHAR(99) NOT NULL, 
	primary_indicator_flag BOOLEAN NOT NULL
);

DROP TABLE IF EXISTS icis.npdes_ps_violations;

CREATE TABLE icis.npdes_ps_violations (
	npdes_id VARCHAR(9) NOT NULL, 
	npdes_violation_id BIGINT NOT NULL, 
	perm_schedule_event_id BIGINT NOT NULL, 
	violation_type_code VARCHAR(1) NOT NULL, 
	violation_code VARCHAR(3) NOT NULL, 
	violation_desc VARCHAR(42) NOT NULL, 
	schedule_event_code VARCHAR(5) NOT NULL, 
	schedule_event_desc VARCHAR(98) NOT NULL, 
	schedule_date DATE NOT NULL, 
	rnc_detection_code VARCHAR(4), 
	rnc_detection_desc VARCHAR(34), 
	rnc_detection_date DATE, 
	rnc_resolution_code VARCHAR(4), 
	rnc_resolution_desc VARCHAR(80), 
	rnc_resolution_date DATE
);

DROP TABLE IF EXISTS icis.npdes_qncr_history;

CREATE TABLE icis.npdes_qncr_history (
	npdes_id VARCHAR(9) NOT NULL, 
	yearqtr INTEGER NOT NULL, 
	hlrnc VARCHAR(4), 
	nume90q INTEGER NOT NULL, 
	numcvdt INTEGER NOT NULL, 
	numsvcd INTEGER NOT NULL, 
	numpsch INTEGER NOT NULL
);


DROP TABLE IF EXISTS icis.npdes_se_violations;
 
CREATE TABLE icis.npdes_se_violations (
	npdes_id VARCHAR(9) NOT NULL, 
	npdes_violation_id BIGINT NOT NULL, 
	violation_type_code VARCHAR(1) NOT NULL, 
	violation_code VARCHAR(5) NOT NULL, 
	violation_desc VARCHAR(100) NOT NULL, 
	single_event_violation_date DATE NOT NULL, 
	single_event_begin_date DATE, 
	single_event_end_date DATE, 
	single_event_violation_comment VARCHAR, 
	single_event_agency_type_code VARCHAR(4), 
	rnc_detection_code VARCHAR(4), 
	rnc_detection_desc VARCHAR(34), 
	rnc_detection_date DATE, 
	rnc_resolution_code VARCHAR(4), 
	rnc_resolution_desc VARCHAR(80), 
	rnc_resolution_date DATE
);

DROP TABLE IF EXISTS icis.npdes_sics;

CREATE TABLE icis.npdes_sics (
	npdes_id VARCHAR(9) NOT NULL, 
	sic_code VARCHAR(4) NOT NULL, 
	sic_desc VARCHAR(50) NOT NULL, 
	primary_indicator_flag BOOLEAN NOT NULL
);

--- ------------ ICIS FE&C (case_downloads.zip)

DROP TABLE IF EXISTS icis.fec_enforcements;

CREATE TABLE icis.fec_enforcements (
	activity_id VARCHAR NOT NULL, 
	activity_name VARCHAR, 
	state_code VARCHAR, 
	region_code VARCHAR(2), 
	fiscal_year INTEGER, 
	case_number VARCHAR, 
	case_name VARCHAR, 
	activity_type_code VARCHAR, 
	activity_type_desc VARCHAR, 
	activity_status_code VARCHAR, 
	activity_status_desc VARCHAR, 
	activity_status_date DATE, 
	lead VARCHAR, 
	case_status_date DATE, 
	doj_docket_nmbr VARCHAR, 
	enf_outcome_code VARCHAR, 
	enf_outcome_desc VARCHAR, 
	total_penalty_assessed_amt VARCHAR, 
	total_cost_recovery_amt VARCHAR, 
	total_comp_action_amt VARCHAR, 
	hq_division VARCHAR, 
	branch VARCHAR, 
	voluntary_self_disclosure_flag BOOLEAN, 
	multimedia_flag BOOLEAN, 
	enf_summary_text VARCHAR
);

DROP TABLE IF EXISTS icis.fec_violations; 

CREATE TABLE icis.fec_violations (
	activity_id VARCHAR NOT NULL, 
	case_number VARCHAR NOT NULL, 
	violation_type_code VARCHAR, 
	rank_order BIGINT, 
	violation_type_desc VARCHAR
);

DROP TABLE IF EXISTS icis.fec_enforcement_type;

CREATE TABLE icis.fec_enforcement_type (
	activity_id VARCHAR NOT NULL, 
	case_number VARCHAR NOT NULL, 
	enf_type_code VARCHAR NOT NULL, 
	enf_type_desc VARCHAR NOT NULL
);

DROP TABLE IF EXISTS icis.fec_relief_sought;

CREATE TABLE icis.fec_relief_sought (
	activity_id BIGINT NOT NULL, 
	case_number VARCHAR(20) NOT NULL, 
	relief_code VARCHAR(3) NOT NULL, 
	relief_desc VARCHAR(39) NOT NULL
);

DROP TABLE IF EXISTS icis.fec_penalties;

CREATE TABLE icis.fec_penalties (
	activity_id VARCHAR NOT NULL, 
	case_number VARCHAR NOT NULL, 
	fed_penalty FLOAT, 
	st_lcl_penalty FLOAT, 
	total_sep FLOAT, 
	compliance_action_cost FLOAT, 
	federal_cost_recovery_amt VARCHAR, 
	state_local_cost_recovery_amt VARCHAR
);

DROP TABLE IF EXISTS icis.fec_law_sections;

CREATE TABLE icis.fec_law_sections (
	activity_id VARCHAR, 
	case_number VARCHAR, 
	rank_order BIGINT, 
	statute_code VARCHAR, 
	law_section_code VARCHAR, 
	law_section_desc VARCHAR
);

DROP TABLE IF EXISTS icis.fec_facilities;

CREATE TABLE icis.fec_facilities (
	activity_id VARCHAR NOT NULL, 
	case_number VARCHAR NOT NULL, 
	registry_id BIGINT, 
	facility_name VARCHAR, 
	location_address VARCHAR, 
	city VARCHAR, 
	state_code VARCHAR, 
	zip VARCHAR, 
	primary_sic_code BIGINT, 
	primary_naics_code BIGINT
);

DROP TABLE IF EXISTS icis.fec_defendants;

CREATE TABLE icis.fec_defendants (
	activity_id VARCHAR NOT NULL, 
	case_number VARCHAR NOT NULL, 
	defendant_name VARCHAR, 
	named_in_complaint_flag BOOLEAN, 
	named_in_settlement_flag BOOLEAN
);

DROP TABLE IF EXISTS icis.fec_milestones;

CREATE TABLE icis.fec_milestones (
	activity_id VARCHAR NOT NULL, 
	case_number VARCHAR NOT NULL, 
	sub_activity_type_code VARCHAR, 
	sub_activity_type_desc VARCHAR, 
	actual_date DATE
);

DROP TABLE IF EXISTS icis.fec_pollutants;


CREATE TABLE icis.fec_pollutants (
	activity_id BIGINT NOT NULL, 
	case_number VARCHAR(25) NOT NULL, 
	pollutant_code INTEGER NOT NULL, 
	pollutant_desc VARCHAR(83), 
	chemical_abstract_service_nmbr VARCHAR(9)
);

DROP TABLE IF EXISTS icis.fec_enforcement_conclusions;

CREATE TABLE icis.fec_enforcement_conclusions (
	activity_id VARCHAR NOT NULL, 
	case_number VARCHAR NOT NULL, 
	enf_conclusion_id VARCHAR NOT NULL, 
	enf_conclusion_nmbr VARCHAR NOT NULL, 
	enf_conclusion_action_code VARCHAR NOT NULL, 
	enf_conclusion_name VARCHAR NOT NULL, 
	settlement_lodged_date DATE, 
	settlement_entered_date DATE, 
	fed_penalty_assessed_amt FLOAT, 
	state_local_penalty_amt FLOAT, 
	sep_amt FLOAT, 
	compliance_action_cost FLOAT, 
	cost_recovery_awarded_amt FLOAT
);

DROP TABLE IF EXISTS icis.fec_enforcement_conclusion_pollutants;

CREATE TABLE icis.fec_enforcement_conclusion_pollutants (
	activity_id VARCHAR NOT NULL, 
	case_number VARCHAR NOT NULL, 
	enf_conclusion_id VARCHAR NOT NULL, 
	comp_action_id VARCHAR, 
	environmental_impact_id BIGINT NOT NULL, 
	sep_id VARCHAR, 
	pollutant_code INTEGER NOT NULL, 
	pollutant_name VARCHAR NOT NULL, 
	average_annual_value FLOAT, 
	pollutant_unit_code VARCHAR, 
	media_code VARCHAR, 
	media_desc VARCHAR, 
	sep_or_comp_flag VARCHAR(1) 
);

DROP TABLE IF EXISTS icis.fec_enforcement_conclusion_complying_actions;

CREATE TABLE icis.fec_enforcement_conclusion_complying_actions (
	activity_id VARCHAR NOT NULL, 
	case_number VARCHAR NOT NULL, 
	enf_conclusion_id VARCHAR NOT NULL, 
	comp_action_id VARCHAR NOT NULL, 
	comp_action_description VARCHAR, 
	comp_action_type_code VARCHAR(3) NOT NULL, 
	comp_action_type_desc VARCHAR NOT NULL, 
	comp_action_category_type_desc VARCHAR NOT NULL
);

DROP TABLE IF EXISTS icis.fec_enforcement_conclusion_facilities;

CREATE TABLE icis.fec_enforcement_conclusion_facilities (
	activity_id VARCHAR NOT NULL, 
	case_number VARCHAR NOT NULL, 
	enf_conclusion_id VARCHAR NOT NULL, 
	icis_facility_interest_id BIGINT NOT NULL, 
	facility_uin BIGINT, 
	facility_name VARCHAR, 
	facility_city VARCHAR, 
	facility_state VARCHAR, 
	facility_zip VARCHAR
);

DROP TABLE IF EXISTS icis.fec_enforcement_conclusion_sep;

CREATE TABLE icis.fec_enforcement_conclusion_sep (
	activity_id VARCHAR NOT NULL, 
	case_number VARCHAR NOT NULL, 
	enf_conclusion_id VARCHAR NOT NULL, 
	sep_category_code VARCHAR NOT NULL, 
	sep_category_desc VARCHAR NOT NULL, 
	sep_id BIGINT NOT NULL, 
	sep_text VARCHAR, 
	sep_amt FLOAT
);

DROP TABLE IF EXISTS icis.fec_enforcement_conclusion_dollars;

CREATE TABLE icis.fec_enforcement_conclusion_dollars (
	activity_id VARCHAR NOT NULL, 
	case_number VARCHAR NOT NULL, 
	enf_conclusion_id VARCHAR NOT NULL, 
	state_local_penalty_amt FLOAT, 
	cost_recovery_amt FLOAT NOT NULL, 
	fed_penalty FLOAT NOT NULL, 
	compliance_action_cost FLOAT NOT NULL, 
	sep_cost FLOAT
);

DROP TABLE IF EXISTS icis.fec_regional_dockets;

CREATE TABLE icis.fec_regional_dockets (
	activity_id VARCHAR NOT NULL, 
	case_number VARCHAR NOT NULL, 
	regional_docket_nmbr VARCHAR
);

DROP TABLE IF EXISTS icis.fec_related_activities;

CREATE TABLE icis.fec_related_activities (
	activity_id VARCHAR NOT NULL, 
	case_number VARCHAR NOT NULL, 
	activity_status_date DATE, 
	activity_type_code VARCHAR, 
	activity_type_desc VARCHAR
);


------ ICIS AIR 

DROP TABLE IF EXISTS icis.air_facilities;

CREATE TABLE icis.air_facilities (
	pgm_sys_id VARCHAR(18) NOT NULL, 
	registry_id BIGINT, 
	facility_name VARCHAR(80) NOT NULL, 
	street_address VARCHAR(50), 
	city VARCHAR(55), 
	county_name VARCHAR(35) NOT NULL, 
	state VARCHAR(2) NOT NULL, 
	zip_code VARCHAR(10) NOT NULL, 
	epa_region VARCHAR(2) NOT NULL, 
	sic_codes VARCHAR(34), 
	naics_codes VARCHAR(27), 
	facility_type_code VARCHAR(4), 
	air_pollutant_class_code VARCHAR(4), 
	air_pollutant_class_desc VARCHAR(32), 
	air_operating_status_code VARCHAR(4), 
	air_operating_status_desc VARCHAR(18), 
	current_hpv VARCHAR(12) NOT NULL, 
	local_control_region_code VARCHAR(4), 
	local_control_region_name VARCHAR(67)
);

DROP TABLE IF EXISTS icis.air_programs;

CREATE TABLE icis.air_programs (
	pgm_sys_id VARCHAR(18) NOT NULL, 
	program_code VARCHAR NOT NULL, 
	program_desc VARCHAR NOT NULL, 
	air_operating_status_code VARCHAR(3) NOT NULL, 
	air_operating_status_desc VARCHAR(18) NOT NULL
);

DROP TABLE IF EXISTS icis.air_program_subparts;

CREATE TABLE icis.air_program_subparts (
	pgm_sys_id VARCHAR(18) NOT NULL, 
	program_code VARCHAR NOT NULL, 
	program_desc VARCHAR NOT NULL, 
	air_program_subpart_code VARCHAR NOT NULL, 
	air_program_subpart_desc VARCHAR NOT NULL
);

DROP TABLE IF EXISTS icis.air_titlev_certs;

CREATE TABLE icis.air_titlev_certs (
	pgm_sys_id VARCHAR(18) NOT NULL, 
	activity_id BIGINT NOT NULL, 
	comp_monitor_type_code VARCHAR(3) NOT NULL, 
	comp_monitor_type_desc VARCHAR(21) NOT NULL, 
	state_epa_flag VARCHAR(1) NOT NULL, 
	actual_end_date DATE, 
	facility_rpt_deviation_flag BOOLEAN 
);

DROP TABLE IF EXISTS icis.air_fces_pces;

CREATE TABLE icis.air_fces_pces (
	pgm_sys_id VARCHAR(18) NOT NULL, 
	activity_id BIGINT NOT NULL, 
	state_epa_flag VARCHAR(1) NOT NULL, 
	activity_type_code VARCHAR(3) NOT NULL, 
	activity_type_desc VARCHAR(21) NOT NULL, 
	comp_monitor_type_code VARCHAR(3) NOT NULL, 
	comp_monitor_type_desc VARCHAR(40) NOT NULL, 
	actual_end_date DATE NOT NULL, 
	program_codes VARCHAR NOT NULL
);

DROP TABLE IF EXISTS icis.air_formal_actions;

CREATE TABLE icis.air_formal_actions (
	pgm_sys_id VARCHAR(18) NOT NULL, 
	activity_id BIGINT NOT NULL, 
	enf_identifier VARCHAR(25) NOT NULL, 
	activity_type_code VARCHAR(3) NOT NULL, 
	activity_type_desc VARCHAR(23) NOT NULL, 
	state_epa_flag VARCHAR(1) NOT NULL, 
	enf_type_code VARCHAR(7) NOT NULL, 
	enf_type_desc VARCHAR(70) NOT NULL, 
	settlement_entered_date DATE, 
	penalty_amount FLOAT NOT NULL
);

DROP TABLE IF EXISTS icis.air_hpv_history;

CREATE TABLE icis.air_hpv_history (
	pgm_sys_id VARCHAR(18) NOT NULL, 
	activity_id BIGINT NOT NULL, 
	agency_type_desc VARCHAR(8) NOT NULL,
	state_code VARCHAR(2), 
	air_lcon_code VARCHAR(3),
	comp_determination_uid VARCHAR(25) NOT NULL,
	enf_response_policy_code VARCHAR(3) NOT NULL, 
	program_codes VARCHAR NOT NULL, 
	program_descs VARCHAR NOT NULL, 
	pollutant_codes VARCHAR(181) NOT NULL, 
	pollutant_descs VARCHAR(320) NOT NULL, 
	earliest_frv_determ_date DATE, 
	hpv_dayzero_date DATE, 
	hpv_resolved_date DATE
);

DROP TABLE IF EXISTS icis.air_informal_actions;

CREATE TABLE icis.air_informal_actions (
	pgm_sys_id VARCHAR(18) NOT NULL, 
	activity_id BIGINT NOT NULL, 
	enf_identifier VARCHAR(25) NOT NULL, 
	activity_type_code VARCHAR(3) NOT NULL, 
	activity_type_desc VARCHAR(25) NOT NULL, 
	state_epa_flag VARCHAR(1) NOT NULL, 
	enf_type_code VARCHAR(5) NOT NULL, 
	enf_type_desc VARCHAR(35) NOT NULL, 
	achieved_date DATE, 
	penalty_amount INTEGER NOT NULL
);

DROP TABLE IF EXISTS icis.air_pollutants;

CREATE TABLE icis.air_pollutants (
	pgm_sys_id VARCHAR(18) NOT NULL, 
	pollutant_code BIGINT NOT NULL, 
	pollutant_desc VARCHAR(70) NOT NULL, 
	srs_id VARCHAR(9), 
	chemical_abstract_service_nmbr BIGINT, 
	air_pollutant_class_code VARCHAR(3) NOT NULL, 
	air_pollutant_class_desc VARCHAR(32) NOT NULL
);

DROP TABLE IF EXISTS icis.air_stack_tests;

CREATE TABLE icis.air_stack_tests (
	pgm_sys_id VARCHAR(18) NOT NULL, 
	activity_id BIGINT NOT NULL, 
	comp_monitor_type_code VARCHAR(3) NOT NULL, 
	comp_monitor_type_desc VARCHAR(10) NOT NULL, 
	state_epa_flag VARCHAR(1) NOT NULL, 
	actual_end_date DATE, 
	pollutant_codes VARCHAR(70),
	pollutant_descs VARCHAR(2),
	air_stack_test_status_code VARCHAR(3),
	air_stack_test_status_desc VARCHAR(10)
);





