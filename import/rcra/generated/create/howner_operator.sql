--- howner_operator

DROP TABLE IF EXISTS rcra.howner_operator; 
CREATE TABLE rcra.howner_operator( 
epa_handler_id VARCHAR,
activity_location VARCHAR,
source_type VARCHAR,
handler_sequence_number BIGINT,
owner_operator_sequence_number BIGINT,
owner_operator_indicator VARCHAR,
owner_operator_name VARCHAR,
owner_operator_type VARCHAR,
date_became_current DATE,
date_ended_current DATE,
owner_operator_street_1 VARCHAR,
owner_operator_street_2 VARCHAR,
owner_operator_city VARCHAR,
owner_operator_state VARCHAR,
owner_operator_country VARCHAR,
owner_operator_zip_code VARCHAR,
owner_operator_phone VARCHAR,
owner_operator_street_number VARCHAR
);

