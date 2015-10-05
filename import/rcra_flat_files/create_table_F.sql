--- fcost_estimate

CREATE TABLE fcost_estimate( 
epa_handler_id VARCHAR,
cost_estimate_activity_location VARCHAR,
financial_assurance_type VARCHAR,
cost_estimate_responsible_agency_ VARCHAR,
cost_coverage_sequence_number_ BIGINT,
cost_estimate_responsible_person_owner VARCHAR,
cost_estimate_responsible_person VARCHAR,
cost_estimate_amount FLOAT,
cost_estimate_date DATE,
cost_estimate_reason VARCHAR,
ca_area_or_permit_unit_notes VARCHAR,
user_id_of_last_change VARCHAR,
date_of_last_change DATE,
notes VARCHAR
);

--- fln_cost_mechanism_detail

CREATE TABLE fln_cost_mechanism_detail( 
cost_estimate_handler_id VARCHAR,
cost_estimate_activity_location VARCHAR,
financial_assurance_type VARCHAR,
cost_estimate_responsible_agency_ VARCHAR,
cost_coverage_sequence_number_ BIGINT,
mechanism_handler_id VARCHAR,
mechanism_activity_location VARCHAR,
mechanism_agency VARCHAR,
mechanism_sequence_number_ BIGINT,
mechanism_detail_sequence_number_ BIGINT,
user_id_of_last_change VARCHAR,
date_of_last_change DATE
);

--- fmechanism_detail

CREATE TABLE fmechanism_detail( 
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

--- fmechanism

CREATE TABLE fmechanism( 
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

