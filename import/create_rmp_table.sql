CREATE SCHEMA IF NOT EXISTS rmp;

DROP TABLE IF EXISTS rmp.rmp_inspections;

CREATE TABLE rmp.rmp_inspections (
	activity_id BIGINT NOT NULL, 
	activity_name VARCHAR(100) NOT NULL, 
	activity_type_desc VARCHAR(21) NOT NULL, 
	activity_status_desc VARCHAR(8), 
	actual_end_date DATE, 
	state_epa_flag VARCHAR(1) NOT NULL, 
	law_sections VARCHAR(95) NOT NULL, 
	comp_monitor_category_desc VARCHAR(35) NOT NULL, 
	comp_monitor_type_desc VARCHAR(62) NOT NULL, 
	observed_deficiency_flag BOOLEAN, 
	communicate_deficiency_flag BOOLEAN, 
	facility_action_flag BOOLEAN, 
	general_comp_assistance_flag BOOLEAN, 
	specific_comp_assistance_flag BOOLEAN, 
	deficiency_desc VARCHAR(715), 
	facility_uin BIGINT, 
	primary_name VARCHAR(80) NOT NULL, 
	location_address VARCHAR(50), 
	city_name VARCHAR(25), 
	state_code VARCHAR(2) NOT NULL, 
	epa_region_code VARCHAR(4)
);
