--- fmechanism

DROP TABLE IF EXISTS rcra.fmechanism; 
CREATE TABLE rcra.fmechanism( 
epa_handler_id VARCHAR,
mechanism_activity_location VARCHAR,
mechanism_agency VARCHAR,
mechanism_sequence_number_ BIGINT,
mechanism_type_owner VARCHAR,
mechanism_type VARCHAR,
provider VARCHAR,
provider_contact_name_ VARCHAR,
provider_contact_phone_number VARCHAR,
user_id_of_last_change VARCHAR,
date_of_last_change DATE,
notes VARCHAR
);

