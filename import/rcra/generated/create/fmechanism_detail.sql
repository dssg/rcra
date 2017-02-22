--- fmechanism_detail

DROP TABLE IF EXISTS rcra.fmechanism_detail; 
CREATE TABLE rcra.fmechanism_detail( 
epa_handler_id VARCHAR,
mechanism_activity_location VARCHAR,
mechanism_agency VARCHAR,
mechanism_sequence_number_ BIGINT,
mechanism_detail_sequence_number_ BIGINT,
mechanism_identification VARCHAR,
face_value_amount FLOAT,
effective_date DATE,
expiration_date DATE,
user_id_of_last_change VARCHAR,
date_of_last_change DATE,
notes VARCHAR
);

