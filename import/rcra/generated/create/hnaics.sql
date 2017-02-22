--- hnaics

DROP TABLE IF EXISTS rcra.hnaics; 
CREATE TABLE rcra.hnaics( 
epa_handler_id VARCHAR,
activity_location VARCHAR,
source_type VARCHAR,
sequence_number BIGINT,
naics_sequence_number BIGINT,
naics_code_owner VARCHAR,
naics_code VARCHAR
);

