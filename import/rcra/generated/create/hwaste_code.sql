--- hwaste_code

DROP TABLE IF EXISTS rcra.hwaste_code; 
CREATE TABLE rcra.hwaste_code( 
epa_handler_id VARCHAR,
activity_location VARCHAR,
source_type VARCHAR,
handler_sequence_number BIGINT,
hazardous_waste_code_owner VARCHAR,
hazardous_waste_code VARCHAR
);

