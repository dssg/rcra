--- hstate_activity

DROP TABLE IF EXISTS rcra.hstate_activity; 
CREATE TABLE rcra.hstate_activity( 
epa_handler_id VARCHAR,
activity_location VARCHAR,
source_type VARCHAR,
handler_sequence_number BIGINT,
state_activity_type_owner VARCHAR,
state_activity_type VARCHAR
);

