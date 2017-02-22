--- hpart_a

DROP TABLE IF EXISTS rcra.hpart_a; 
CREATE TABLE rcra.hpart_a( 
epa_handler_id VARCHAR,
activity_location VARCHAR,
source_type VARCHAR,
handler_sequence_number BIGINT,
permit_contact_first_name VARCHAR,
permit_contact_middle_initial VARCHAR,
permit_contact_last_name VARCHAR,
permit_contact_street_number VARCHAR,
permit_contact_street_1 VARCHAR,
permit_contact_street_2 VARCHAR,
permit_contact_city VARCHAR,
permit_contact_state VARCHAR,
permit_contact_zip_code VARCHAR,
permit_contact_country VARCHAR,
permit_contact_phone VARCHAR,
permit_contact_phone_extension VARCHAR,
permit_contact_email_address VARCHAR,
permit_contact_title VARCHAR,
tsd_date DATE
);

