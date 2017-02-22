--- fln_cost_mechanism_detail

DROP TABLE IF EXISTS rcra.fln_cost_mechanism_detail; 
CREATE TABLE rcra.fln_cost_mechanism_detail( 
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

