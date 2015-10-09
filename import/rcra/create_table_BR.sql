--- br_reporting

CREATE TABLE rcra.br_reporting( 
handler_id VARCHAR,
activity_location VARCHAR,
source_type VARCHAR,
sequence_number BIGINT,
hazardous_waste_page_number VARCHAR,
hazardous_waste_sub_page_number VARCHAR,
br_form VARCHAR,
management_location VARCHAR,
report_cycle VARCHAR,
state VARCHAR,
state_name VARCHAR,
region VARCHAR,
handler_name VARCHAR,
location_street_number VARCHAR,
location_street_1 VARCHAR,
location_street_2 VARCHAR,
location_city VARCHAR,
location_state VARCHAR,
location_zip VARCHAR,
county_code VARCHAR,
county_name VARCHAR,
state_district VARCHAR,
generator_id_included_in_nbr VARCHAR,
generator_waste_stream_included_in_nbr VARCHAR,
manager_id_included_in_nbr VARCHAR,
manager_waste_stream_included_in_nbr VARCHAR,
shipper_id_included_in_nbr VARCHAR,
shipper_waste_stream_included_in_nbr VARCHAR,
receiver_id_included_in_nbr VARCHAR,
receiver_waste_stream_included_in_nbr VARCHAR,
waste_description VARCHAR,
primary_naics VARCHAR,
source_code VARCHAR,
form_code VARCHAR,
management_method VARCHAR,
federal_waste_flag VARCHAR,
wastewater_characteristic_indicator VARCHAR,
generation_tons FLOAT,
managed_tons FLOAT,
shipped_tons FLOAT,
received_tons FLOAT,
receiver_id VARCHAR,
receiver_state VARCHAR,
receiver_state_name VARCHAR,
receiver_region VARCHAR,
shipper_id VARCHAR,
shipper_state VARCHAR,
shipper_state_name VARCHAR,
shipper_region VARCHAR,
waste_minimization_code VARCHAR,
waste_code_group VARCHAR
);

--- bgm_waste_code

CREATE TABLE rcra.bgm_waste_code( 
handler_id VARCHAR,
activity_location VARCHAR,
source_type VARCHAR,
sequence_number BIGINT,
hazardous_waste_page_number BIGINT,
waste_code_owner VARCHAR,
waste_code VARCHAR
);

--- bwr_waste_code

CREATE TABLE rcra.bwr_waste_code( 
handler_id VARCHAR,
activity_location VARCHAR,
source_type VARCHAR,
sequence_number BIGINT,
hazardous_waste_page_number BIGINT,
hazardous_waste_sub_page_number BIGINT,
waste_code_owner VARCHAR,
waste_code VARCHAR
);

