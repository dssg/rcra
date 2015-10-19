--- fcost_estimate

CREATE TABLE rcra.fcost_estimate( 
epa_handler_id VARCHAR,
cost_estimate_activity_location VARCHAR,
financial_assurance_type VARCHAR,
cost_estimate_responsible_agency_ VARCHAR,
cost_coverage_sequence_number_ VARCHAR,
cost_estimate_responsible_person_owner VARCHAR,
cost_estimate_responsible_person VARCHAR,
cost_estimate_amount VARCHAR,
cost_estimate_date VARCHAR,
cost_estimate_reason VARCHAR,
ca_area_or_permit_unit_notes VARCHAR,
user_id_of_last_change VARCHAR,
date_of_last_change VARCHAR,
notes VARCHAR
);

--- fln_cost_mechanism_detail

CREATE TABLE rcra.fln_cost_mechanism_detail( 
cost_estimate_handler_id VARCHAR,
cost_estimate_activity_location VARCHAR,
financial_assurance_type VARCHAR,
cost_estimate_responsible_agency_ VARCHAR,
cost_coverage_sequence_number_ VARCHAR,
mechanism_handler_id VARCHAR,
mechanism_activity_location VARCHAR,
mechanism_agency VARCHAR,
mechanism_sequence_number_ VARCHAR,
mechanism_detail_sequence_number_ VARCHAR,
user_id_of_last_change VARCHAR,
date_of_last_change VARCHAR
);

--- fmechanism_detail

CREATE TABLE rcra.fmechanism_detail( 
epa_handler_id VARCHAR,
mechanism_activity_location VARCHAR,
mechanism_agency VARCHAR,
mechanism_sequence_number_ VARCHAR,
mechanism_detail_sequence_number_ VARCHAR,
mechanism_identification VARCHAR,
face_value_amount VARCHAR,
effective_date VARCHAR,
expiration_date VARCHAR,
user_id_of_last_change VARCHAR,
date_of_last_change VARCHAR,
notes VARCHAR
);

--- fmechanism

CREATE TABLE rcra.fmechanism( 
epa_handler_id VARCHAR,
mechanism_activity_location VARCHAR,
mechanism_agency VARCHAR,
mechanism_sequence_number_ VARCHAR,
mechanism_type_owner VARCHAR,
mechanism_type VARCHAR,
provider VARCHAR,
provider_contact_name_ VARCHAR,
provider_contact_phone_number VARCHAR,
user_id_of_last_change VARCHAR,
date_of_last_change VARCHAR,
notes VARCHAR
);

