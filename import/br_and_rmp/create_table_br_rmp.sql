


CREATE TABLE brs_all (
	handler_id VARCHAR, 
	activity_location VARCHAR, 
	source_type VARCHAR, 
	seq_number VARCHAR, 
	hz_pg VARCHAR, 
	sub_page_num VARCHAR, 
	br_form VARCHAR, 
	management_location VARCHAR, 
	report_cycle VARCHAR, 
	state VARCHAR, 
	state_name VARCHAR, 
	region VARCHAR, 
	handler_name VARCHAR, 
	location_street_no VARCHAR, 
	location_street1 VARCHAR, 
	location_street2 VARCHAR, 
	location_city VARCHAR, 
	location_state VARCHAR, 
	location_zip VARCHAR, 
	county_code VARCHAR, 
	county_name VARCHAR, 
	state_district VARCHAR, 
	gen_id_included_in_nbr VARCHAR, 
	gen_waste_included_in_nbr VARCHAR, 
	mgmt_id_included_in_nbr VARCHAR,
	mgmt_waste_included_in_nbr VARCHAR,
	ship_id_included_in_nbr VARCHAR,
	ship_waste_included_in_nbr VARCHAR,
	recv_id_included_in_nbr VARCHAR, 
	recv_waste_included_in_nbr VARCHAR,
	description VARCHAR, 
	primary_naics VARCHAR, 
	source_code VARCHAR, 
	form_code VARCHAR, 
	management_method VARCHAR, 
	federal_waste VARCHAR, 
	wastewater VARCHAR, 
	generation_tons VARCHAR, 
	managed_tons VARCHAR, 
	shipped_tons VARCHAR, 
	received_tons VARCHAR, 
	receiver_id VARCHAR, 
	receiver_state VARCHAR, 
	receiver_state_name VARCHAR, 
	receiver_region VARCHAR, 
	shipper_id VARCHAR, 
	shipper_state VARCHAR, 
	shipper_state_name VARCHAR, 
	shipper_region VARCHAR, 
	federal_waste_codes VARCHAR, 
	waste_min_code VARCHAR, 
	waste_code_group VARCHAR, 
	calculated_generator_status VARCHAR, 
	acute_nonacute_status VARCHAR, 
	waste_generation_activity VARCHAR, 
	priority_chemical VARCHAR, 
	management_category VARCHAR
);

--------------------------------
---change report cycle into date 
--------------------------------

-- First, add new column with date format
alter table brs_all add column date_year date; 

-- convert dates column into date format and put in date_format column
update brs_all
set date_year = to_date("report_cycle", 'YYYY-MM');

----------------------------------------------
-- first convert waste numbers into floats to later sum
---------------------------------------------- 
alter table brs_all add column gen_tons real;
alter table brs_all alter column gen_tons type float using "generation_tons"::float;
alter table brs_all add column man_tons real;
alter table brs_all alter column man_tons type float using "managed_tons"::float;
alter table brs_all add column ship_tons real;
alter table brs_all alter column ship_tons type float using "shipped_tons"::float;
alter table brs_all add column rec_tons real;
alter table brs_all alter column rec_tons type float using "received_tons"::float;

-------------------------------------
--- Waste shipped but not generated or managed 
-------------------------------------
alter table brs_all add column ship_not_man_or_gen int;

update brs_all
	set rec_not_man_or_gen = case when (ship_tons > 0 and man_tons = 0) and
	(ship_tons > 0 and gen_tons = 0) then 1 else 0 end;

------------------------------------
-- Waste receieved by not generated or managed
------------------------------------
alter table brs_all add column rec_not_man_or_gen int;	


update brs_all
	set rec_not_man_or_gen = case when (rec_tons > 0 and man_tons = 0) and
	(rec_tons > 0 and gen_tons = 0) then 1 else 0 end;
		


CREATE TABLE "rmp_caa_inspection" (
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




