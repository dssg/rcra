--- ccitation

DROP TABLE IF EXISTS rcra.ccitation; 
CREATE TABLE rcra.ccitation( 
handler_id VARCHAR,
violation_activity_location VARCHAR,
violation_sequence_number BIGINT,
violation_determined_by_agency VARCHAR,
citation_sequence_number BIGINT,
violation_owner VARCHAR,
violation_type VARCHAR,
citation_owner VARCHAR,
citation VARCHAR,
citation_type VARCHAR
);

