--- fcost_estimate

DROP TABLE IF EXISTS rcra.fcost_estimate; 
CREATE TABLE rcra.fcost_estimate( 
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

