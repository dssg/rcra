--- hother_permit

DROP TABLE IF EXISTS rcra.hother_permit; 
CREATE TABLE rcra.hother_permit( 
epa_handler_id VARCHAR,
activity_location VARCHAR,
source_type VARCHAR,
handler_sequence_number BIGINT,
other_permit_number VARCHAR,
other_permit_type_owner VARCHAR,
other_permit_type VARCHAR,
other_permit_description VARCHAR
);

