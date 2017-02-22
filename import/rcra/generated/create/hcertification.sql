--- hcertification

DROP TABLE IF EXISTS rcra.hcertification; 
CREATE TABLE rcra.hcertification( 
epa_handler_id VARCHAR,
activity_location VARCHAR,
source_type VARCHAR,
handler_sequence_number BIGINT,
certification_sequence_number BIGINT,
certification_signed_date DATE,
certification_title VARCHAR,
certification_first_name VARCHAR,
certification_middle_initial VARCHAR,
certification_last_name VARCHAR
);

