--- aarea

CREATE TABLE rcra.aarea( 
epa_handler_id VARCHAR,
area_sequence_number VARCHAR,
facility_wide_indicator VARCHAR,
regulated_unit_indicator VARCHAR,
area_name VARCHAR,
air_release_indicator VARCHAR,
groundwater_release_indicator VARCHAR,
soil_release_indicator VARCHAR,
surface_waste_release_indicator VARCHAR,
epa_responsible_person_owner VARCHAR,
epa_responsible_person VARCHAR,
state_responsible_person_owner VARCHAR,
state_responsible_person VARCHAR
);

--- aevent

CREATE TABLE rcra.aevent( 
epa_handler_id VARCHAR,
event_sequence_number VARCHAR,
event_responsible_agency VARCHAR,
event_activity_location VARCHAR,
corrective_action_event_owner VARCHAR,
corrective_action_event_code VARCHAR,
original_schedule_date_of_event VARCHAR,
new_schedule_date_of_event VARCHAR,
actual_date_of_event VARCHAR,
best_date VARCHAR,
responsible_person_owner VARCHAR,
responsible_person VARCHAR,
suborganization_owner VARCHAR,
suborganization VARCHAR
);

--- aauthority

CREATE TABLE rcra.aauthority( 
epa_handler_id VARCHAR,
activity_location VARCHAR,
responsible_agency VARCHAR,
authority_owner VARCHAR,
authority_type VARCHAR,
effective_date VARCHAR,
issuance_date VARCHAR,
end_date VARCHAR,
repository VARCHAR,
responsible_person_owner VARCHAR,
responsible_person VARCHAR,
suborganization_owner VARCHAR,
suborganization VARCHAR
);

--- aln_area_event

CREATE TABLE rcra.aln_area_event( 
area_epa_handler_id VARCHAR,
area_sequence_number VARCHAR,
event_epa_handler_id VARCHAR,
event_code_owner VARCHAR,
event_code VARCHAR,
event_sequence_number VARCHAR,
event_responsible_agency VARCHAR,
event_activity_location VARCHAR
);

--- aln_event_authority

CREATE TABLE rcra.aln_event_authority( 
event_epa_handler_id VARCHAR,
event_code_owner VARCHAR,
event_code VARCHAR,
event_sequence_number VARCHAR,
event_responsible_agency VARCHAR,
event_activity_location VARCHAR,
authority_epa_handler_id VARCHAR,
authority_type_owner VARCHAR,
authority_type VARCHAR,
authority_effective_date VARCHAR,
authority_responsible_agency VARCHAR,
authority_activity_location VARCHAR
);

--- alu_ca_event

CREATE TABLE rcra.alu_ca_event( 
corrective_action_event_owner VARCHAR,
corrective_action_event VARCHAR,
corrective_action_event_active_status VARCHAR,
corrective_action_event_description VARCHAR
);

--- alu_authority

CREATE TABLE rcra.alu_authority( 
authority_owner VARCHAR,
authority_type VARCHAR,
authority_type_active_status VARCHAR,
authority_type_description VARCHAR
);

--- aln_authority_citation

CREATE TABLE rcra.aln_authority_citation( 
epa_handler_id VARCHAR,
authority_type_owner VARCHAR,
authority_type VARCHAR,
authority_effective_date VARCHAR,
authority_responsible_agency VARCHAR,
authority_activity_location VARCHAR,
statutory_citation_owner VARCHAR,
statutory_citation VARCHAR
);

--- alu_statutory_citation

CREATE TABLE rcra.alu_statutory_citation( 
statutory_citation_owner VARCHAR,
statutory_citation VARCHAR,
statutory_citation_active_status VARCHAR,
statutory_citation_description VARCHAR
);

--- aln_area_unit

CREATE TABLE rcra.aln_area_unit( 
area_handler_id VARCHAR,
area_handler_sequence VARCHAR,
unit_handler_id VARCHAR,
unit_handler_sequence VARCHAR
);

