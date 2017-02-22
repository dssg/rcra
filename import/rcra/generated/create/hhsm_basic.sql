--- hhsm_basic

DROP TABLE IF EXISTS rcra.hhsm_basic; 
CREATE TABLE rcra.hhsm_basic( 
epa_handler_id VARCHAR,
activity_location VARCHAR,
source_type VARCHAR,
sequence_number BIGINT,
reason_for_notification VARCHAR,
hsm_effective_date DATE,
hsm_fa VARCHAR
);

