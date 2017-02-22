--- hhsm_activity

DROP TABLE IF EXISTS rcra.hhsm_activity; 
CREATE TABLE rcra.hhsm_activity( 
epa_handler_id VARCHAR,
activity_location VARCHAR,
source_type VARCHAR,
sequence_number BIGINT,
hsm_sequence_number BIGINT,
facility_code_owner VARCHAR,
facility_code VARCHAR,
estimate_short_tons BIGINT,
actual_short_tons BIGINT,
land_based_unit VARCHAR
);

