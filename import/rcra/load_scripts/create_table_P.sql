--- pseries

CREATE TABLE rcra.pseries( 
epa_handler_id VARCHAR,
series_sequence_number VARCHAR,
series_name VARCHAR,
responsible_owner VARCHAR,
responsible_person VARCHAR
);

--- pevent

CREATE TABLE rcra.pevent( 
epa_handler_id VARCHAR,
series_sequence_number VARCHAR,
event_sequence_number VARCHAR,
responsible_agency VARCHAR,
activity_location VARCHAR,
permit_event_owner VARCHAR,
permit_event_code VARCHAR,
actual_date_of_event VARCHAR,
original_schedule_date_of_event VARCHAR,
new_schedule_date_of_event VARCHAR,
best_date VARCHAR,
suborganization_owner VARCHAR,
suborganization VARCHAR,
responsible_person_owner VARCHAR,
responsible_person VARCHAR
);

--- punit

CREATE TABLE rcra.punit( 
epa_handler_id VARCHAR,
process_unit_sequence_number VARCHAR,
process_unit_name VARCHAR
);

--- punit_detail

CREATE TABLE rcra.punit_detail( 
epa_handler_id VARCHAR,
process_unit_sequence_number VARCHAR,
process_unit_detail_sequence_number VARCHAR,
process_status_effective_date VARCHAR,
process_capacity VARCHAR,
number_of_units VARCHAR,
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

CREATE TABLE rcra.pln_event_unit_detail( 
event_epa_handler_id VARCHAR,
series_sequence_number VARCHAR,
permit_event_owner VARCHAR,
event_sequence_number VARCHAR,
event_responsible_agency VARCHAR,
activity_location VARCHAR,
permit_event_code VARCHAR,
unit_detail_epa_handler_id VARCHAR,
unit_sequence_number VARCHAR,
unit_detail_sequence_number VARCHAR
);

--- plu_permit_event_code

CREATE TABLE rcra.plu_permit_event_code( 
permit_event_code_owner VARCHAR,
permit_event_code VARCHAR,
permit_event_code_active_status VARCHAR,
event_description VARCHAR
);

--- plu_process_code

CREATE TABLE rcra.plu_process_code( 
process_code_owner VARCHAR,
process_code VARCHAR,
unit_of_measure_owner VARCHAR,
unit_of_measure VARCHAR,
process_code_active_status VARCHAR,
process_type VARCHAR,
process_code_description VARCHAR
);

--- plu_unit_of_measure

CREATE TABLE rcra.plu_unit_of_measure( 
unit_of_measure_owner VARCHAR,
unit_of_measure_type VARCHAR,
unit_of_measure_active_status VARCHAR,
unit_of_measure_description VARCHAR,
unit_of_measure_short_description VARCHAR
);

--- pln_unit_detail_waste

CREATE TABLE rcra.pln_unit_detail_waste( 
handler_id VARCHAR,
unit_sequence VARCHAR,
unit_detail_sequence VARCHAR,
waste_code VARCHAR,
waste_code_owner VARCHAR
);

--- plu_legal_operating_status

CREATE TABLE rcra.plu_legal_operating_status( 
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

