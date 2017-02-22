--- hhsm_waste_code

DROP TABLE IF EXISTS rcra.hhsm_waste_code; 
CREATE TABLE rcra.hhsm_waste_code( 
epa_handler_id VARCHAR,
activity_location VARCHAR,
source_type VARCHAR,
sequence_number BIGINT,
hsm_sequence_number BIGINT,
waste_code_owner VARCHAR,
waste_code VARCHAR
);

