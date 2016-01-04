
DROP TABLE if EXISTS import.brs_all;

CREATE TABLE import.brs_all (
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



