--- pseries

CREATE TABLE pseries( 
epa_handler_id VARCHAR,
series_sequence_number BIGINT,
series_name VARCHAR,
responsible_owner VARCHAR,
responsible_person VARCHAR
);

--- pevent

CREATE TABLE pevent( 
epa_handler_id VARCHAR,
series_sequence_number BIGINT,
event_sequence_number BIGINT,
responsible_agency VARCHAR,
activity_location VARCHAR,
permit_event_owner VARCHAR,
permit_event_code VARCHAR,
actual_date_of_event DATE,
original_schedule_date_of_event DATE,
new_schedule_date_of_event DATE,
best_date DATE,
suborganization_owner VARCHAR,
suborganization VARCHAR,
responsible_person_owner VARCHAR,
responsible_person VARCHAR
);

--- punit

CREATE TABLE punit( 
epa_handler_id VARCHAR,
process_unit_sequence_number BIGINT,
process_unit_name VARCHAR
);

--- punit_detail

CREATE TABLE punit_detail( 
epa_handler_id VARCHAR,
process_unit_sequence_number BIGINT,
process_unit_detail_sequence_number BIGINT,
process_status_effective_date DATE,
process_capacity FLOAT,
number_of_units BIGINT,
capacity_type VARCHAR,
legal_operating_status_owner VARCHAR,
legal_operating_status VARCHAR,
unit_of_measure_owner VARCHAR,
unit_of_measure VARCHAR,
process_code_owner VARCHAR,
process_code VARCHAR,
commercial_status VARCHAR,
standardized_permit_indicator VARCHAR
);

--- pln_event_unit_detail

CREATE TABLE pln_event_unit_detail( 
event_epa_handler_id VARCHAR,
series_sequence_number BIGINT,
permit_event_owner VARCHAR,
event_sequence_number BIGINT,
event_responsible_agency VARCHAR,
activity_location VARCHAR,
permit_event_code VARCHAR,
unit_detail_epa_handler_id VARCHAR,
unit_sequence_number BIGINT,
unit_detail_sequence_number BIGINT
);

--- plu_permit_event_code

CREATE TABLE plu_permit_event_code( 
permit_event_code_owner VARCHAR,
permit_event_code VARCHAR,
permit_event_code_active_status VARCHAR,
event_description VARCHAR
);

--- plu_process_code

CREATE TABLE plu_process_code( 
process_code_owner VARCHAR,
process_code VARCHAR,
unit_of_measure_owner VARCHAR,
unit_of_measure VARCHAR,
process_code_active_status VARCHAR,
process_type VARCHAR,
process_code_description VARCHAR
);

--- plu_unit_of_measure

CREATE TABLE plu_unit_of_measure( 
unit_of_measure_owner VARCHAR,
unit_of_measure_type VARCHAR,
unit_of_measure_active_status VARCHAR,
unit_of_measure_description VARCHAR,
unit_of_measure_short_description VARCHAR
);

--- pln_unit_detail_waste

CREATE TABLE pln_unit_detail_waste( 
handler_id VARCHAR,
unit_sequence BIGINT,
unit_detail_sequence BIGINT,
waste_code VARCHAR,
waste_code_owner VARCHAR
);

--- plu_legal_operating_status

CREATE TABLE plu_legal_operating_status( 
legal_operating_status_code_owner VARCHAR,
legal_operating_status_code VARCHAR,
legal_operating_status_active_status VARCHAR,
legal_operating_status_description VARCHAR,
strange_but_true_flag VARCHAR,
subject_to_inspection VARCHAR,
permit_progress VARCHAR,
permit_workload VARCHAR,
closure_workload VARCHAR,
post_closure_workload VARCHAR,
subject_to_corrective_action VARCHAR,
corrective_action_workload VARCHAR,
full_enforcement VARCHAR,
operating_tsdf VARCHAR,
tsdfs_potentially_subject_to_corrective_action_under_3004_u_v VARCHAR,
tsdfs_only_subject_to_corrective_action_under_discretionary_authorities VARCHAR,
non_tsdfs_where_rcra_corrective_action_has_been_imposed VARCHAR,
2006_gpra_permit_accomplished VARCHAR,
active_site_federally_regulated_tsdf VARCHAR,
active_site_converter_tsdf VARCHAR,
active_site_state_regulated_tsdf VARCHAR,
permit_renewal_workload VARCHAR
);

