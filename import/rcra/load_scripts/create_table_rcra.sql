--- aarea

DROP TABLE IF EXISTS rcra.aarea; 
CREATE TABLE rcra.aarea( 
epa_handler_id VARCHAR,
area_sequence_number BIGINT,
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

DROP TABLE IF EXISTS rcra.aevent; 
CREATE TABLE rcra.aevent( 
epa_handler_id VARCHAR,
event_sequence_number BIGINT,
event_responsible_agency VARCHAR,
event_activity_location VARCHAR,
corrective_action_event_owner VARCHAR,
corrective_action_event_code VARCHAR,
original_schedule_date_of_event DATE,
new_schedule_date_of_event DATE,
actual_date_of_event DATE,
best_date DATE,
responsible_person_owner VARCHAR,
responsible_person VARCHAR,
suborganization_owner VARCHAR,
suborganization VARCHAR
);

--- aauthority

DROP TABLE IF EXISTS rcra.aauthority; 
CREATE TABLE rcra.aauthority( 
epa_handler_id VARCHAR,
activity_location VARCHAR,
responsible_agency VARCHAR,
authority_owner VARCHAR,
authority_type VARCHAR,
effective_date DATE,
issuance_date DATE,
end_date DATE,
repository VARCHAR,
responsible_person_owner VARCHAR,
responsible_person VARCHAR,
suborganization_owner VARCHAR,
suborganization VARCHAR
);

--- aln_area_event

DROP TABLE IF EXISTS rcra.aln_area_event; 
CREATE TABLE rcra.aln_area_event( 
area_epa_handler_id VARCHAR,
area_sequence_number BIGINT,
event_epa_handler_id VARCHAR,
event_code_owner VARCHAR,
event_code VARCHAR,
event_sequence_number BIGINT,
event_responsible_agency VARCHAR,
event_activity_location VARCHAR
);

--- aln_event_authority

DROP TABLE IF EXISTS rcra.aln_event_authority; 
CREATE TABLE rcra.aln_event_authority( 
event_epa_handler_id VARCHAR,
event_code_owner VARCHAR,
event_code VARCHAR,
event_sequence_number BIGINT,
event_responsible_agency VARCHAR,
event_activity_location VARCHAR,
authority_epa_handler_id VARCHAR,
authority_type_owner VARCHAR,
authority_type VARCHAR,
authority_effective_date DATE,
authority_responsible_agency VARCHAR,
authority_activity_location VARCHAR
);

--- alu_ca_event

DROP TABLE IF EXISTS rcra.alu_ca_event; 
CREATE TABLE rcra.alu_ca_event( 
corrective_action_event_owner VARCHAR,
corrective_action_event VARCHAR,
corrective_action_event_active_status VARCHAR,
corrective_action_event_description VARCHAR
);

--- alu_authority

DROP TABLE IF EXISTS rcra.alu_authority; 
CREATE TABLE rcra.alu_authority( 
authority_owner VARCHAR,
authority_type VARCHAR,
authority_type_active_status VARCHAR,
authority_type_description VARCHAR
);

--- aln_authority_citation

DROP TABLE IF EXISTS rcra.aln_authority_citation; 
CREATE TABLE rcra.aln_authority_citation( 
epa_handler_id VARCHAR,
authority_type_owner VARCHAR,
authority_type VARCHAR,
authority_effective_date DATE,
authority_responsible_agency VARCHAR,
authority_activity_location VARCHAR,
statutory_citation_owner VARCHAR,
statutory_citation VARCHAR
);

--- alu_statutory_citation

DROP TABLE IF EXISTS rcra.alu_statutory_citation; 
CREATE TABLE rcra.alu_statutory_citation( 
statutory_citation_owner VARCHAR,
statutory_citation VARCHAR,
statutory_citation_active_status VARCHAR,
statutory_citation_description VARCHAR
);

--- aln_area_unit

DROP TABLE IF EXISTS rcra.aln_area_unit; 
CREATE TABLE rcra.aln_area_unit( 
area_handler_id VARCHAR,
area_handler_sequence BIGINT,
unit_handler_id VARCHAR,
unit_handler_sequence BIGINT
);

--- cmecomp3

DROP TABLE IF EXISTS rcra.cmecomp3; 
CREATE TABLE rcra.cmecomp3( 
handler_id VARCHAR,
evaluation_activity_location VARCHAR,
evaluation_identifier VARCHAR,
evaluation_start_date DATE,
evaluation_agency VARCHAR,
found_violation_flag VARCHAR,
citizen_complaint_flag VARCHAR,
multimedia_inspection_flag VARCHAR,
sampling_flag VARCHAR,
not_subtitle_c_flag VARCHAR,
evaluation_type VARCHAR,
evaluation_type_description VARCHAR,
focus_area VARCHAR,
focus_area_description VARCHAR,
evaluation_responsible_person VARCHAR,
evaluation_suborganization VARCHAR,
handler_activity_location VARCHAR,
handler_name VARCHAR,
region VARCHAR,
state VARCHAR,
land_type VARCHAR,
request_sequence_number BIGINT,
date_of_request DATE,
date_response_received DATE,
request_agency VARCHAR,
request_activity_location VARCHAR,
violation_activity_location VARCHAR,
violation_sequence_number BIGINT,
violation_determined_by_agency VARCHAR,
violation_type VARCHAR,
violation_short_description VARCHAR,
former_citation VARCHAR,
violation_determined_date DATE,
actual_return_to_compliance_date DATE,
return_to_compliance_qualifier VARCHAR,
violation_responsible_agency VARCHAR,
scheduled_compliance_date DATE,
enforcement_activity_location VARCHAR,
enforcement_identifier VARCHAR,
enforcement_action_date DATE,
enforcement_agency VARCHAR,
docket_number VARCHAR,
attorney VARCHAR,
corrective_action_component_flag VARCHAR,
appeal_initiated_date DATE,
appeal_resolved_date DATE,
disposition_status_date DATE,
disposition_status VARCHAR,
disposition_status_description VARCHAR,
cafo_sequence_number BIGINT,
respondent_name VARCHAR,
lead_agency VARCHAR,
enforcement_type VARCHAR,
enforcement_type_description VARCHAR,
enforcement_responsible_person VARCHAR,
enforcement_suborganization VARCHAR,
sep_sequence_number BIGINT,
expenditure_amount FLOAT,
sep_scheduled_completion_date DATE,
sep_actual_completion_date DATE,
sep_defaulted_date DATE,
sep_type VARCHAR,
sep_type_description VARCHAR,
proposed_penalty_amount FLOAT,
final_monetary_amount FLOAT,
paid_amount FLOAT,
final_count BIGINT,
final_amount FLOAT
);

--- ccitation

DROP TABLE IF EXISTS rcra.ccitation; 
CREATE TABLE rcra.ccitation( 
handler_id VARCHAR,
violation_activity_location VARCHAR,
violation_sequence_number BIGINT,
violation_determined_by_agency VARCHAR,
citation_sequence_number BIGINT,
violation_owner VARCHAR,
violation_type VARCHAR,
citation_owner VARCHAR,
citation VARCHAR,
citation_type VARCHAR
);

--- lu_citation

DROP TABLE IF EXISTS rcra.lu_citation; 
CREATE TABLE rcra.lu_citation( 
owner VARCHAR,
citation VARCHAR,
citation_type VARCHAR,
citation_description VARCHAR,
active_status VARCHAR
);

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

--- hbasic

DROP TABLE IF EXISTS rcra.hbasic; 
CREATE TABLE rcra.hbasic( 
epa_handler_id VARCHAR,
epa_facility_identification_code VARCHAR,
current_site_name VARCHAR,
region VARCHAR,
state VARCHAR
);

--- hcertification

DROP TABLE IF EXISTS rcra.hcertification; 
CREATE TABLE rcra.hcertification( 
epa_handler_id VARCHAR,
activity_location VARCHAR,
source_type VARCHAR,
handler_sequence_number BIGINT,
certification_sequence_number BIGINT,
certification_signed_date DATE,
certification_title VARCHAR,
certification_first_name VARCHAR,
certification_middle_initial VARCHAR,
certification_last_name VARCHAR
);

--- hhandler

DROP TABLE IF EXISTS rcra.hhandler; 
CREATE TABLE rcra.hhandler( 
epa_handler_id VARCHAR,
activity_location VARCHAR,
source_type VARCHAR,
handler_sequence_number BIGINT,
receive_date DATE,
current_site_name VARCHAR,
non_notifier VARCHAR,
acknowledge_flag_date DATE,
acknowledge_flag VARCHAR,
accessibility VARCHAR,
location_street_number VARCHAR,
location_street_1 VARCHAR,
location_street_2 VARCHAR,
location_city VARCHAR,
location_state VARCHAR,
location_zip_code VARCHAR,
county_code VARCHAR,
state_district VARCHAR,
land_type VARCHAR,
mailing_street_number VARCHAR,
mailing_street_1 VARCHAR,
mailing_street_2 VARCHAR,
mailing_city VARCHAR,
mailing_state VARCHAR,
mailing_zip_code VARCHAR,
mailing_country VARCHAR,
contact_first_name VARCHAR,
contact_middle_initial VARCHAR,
contact_last_name VARCHAR,
contact_street_number VARCHAR,
contact_street_1 VARCHAR,
contact_street_2 VARCHAR,
contact_city VARCHAR,
contact_state VARCHAR,
contact_zip VARCHAR,
contact_country VARCHAR,
contact_phone VARCHAR,
contact_phone_extension VARCHAR,
contact_fax VARCHAR,
contact_e_mail_address VARCHAR,
contact_title VARCHAR,
federal_waste_generator_code_owner VARCHAR,
federal_waste_generator_code VARCHAR,
state_waste_generator_code_owner VARCHAR,
state_waste_generator_code VARCHAR,
short_term_generator VARCHAR,
importer_activity VARCHAR,
mixed_waste_generator VARCHAR,
transporter_activity VARCHAR,
transfer_facility VARCHAR,
tsd_activity VARCHAR,
recycler_activity VARCHAR,
onsite_burner_exemption VARCHAR,
furnace_exemption VARCHAR,
underground_injection_activity VARCHAR,
receives_waste_from_off_site VARCHAR,
universal_waste_destination_facility VARCHAR,
used_oil_transporter VARCHAR,
used_oil_transfer_facility VARCHAR,
used_oil_processor VARCHAR,
used_oil_refiner VARCHAR,
used_oil_fuel_burner VARCHAR,
used_oil_fuel_marketer_to_burner VARCHAR,
used_oil_specification_marketer VARCHAR,
under_40_cfr_part_262_subpart_k_as_a_college_or_university VARCHAR,
under_40_cfr_part_262_subpart_k_as_a_teaching_hospital VARCHAR,
under_40_cfr_part_262_subpart_k_as_a_non_profit_research_ins VARCHAR,
withdrawal_from_40_cfr_part_262_subpart_k VARCHAR,
include_in_national_report VARCHAR,
reporting_cycle_year BIGINT,
cdx_transaction_id VARCHAR
);

--- hnaics

DROP TABLE IF EXISTS rcra.hnaics; 
CREATE TABLE rcra.hnaics( 
epa_handler_id VARCHAR,
activity_location VARCHAR,
source_type VARCHAR,
sequence_number BIGINT,
naics_sequence_number BIGINT,
naics_code_owner VARCHAR,
naics_code VARCHAR
);

--- hhsm_activity

DROP TABLE IF EXISTS rcra.hhsm_activity; 
CREATE TABLE rcra.hhsm_activity( 
epa_handler_id VARCHAR,
activity_location VARCHAR,
source_type VARCHAR,
sequence_number BIGINT,
hsm_sequence_number BIGINT,
facility_code_owner VARCHAR,
facility_code VARCHAR,
estimate_short_tons BIGINT,
actual_short_tons BIGINT,
land_based_unit VARCHAR
);

--- hhsm_basic

DROP TABLE IF EXISTS rcra.hhsm_basic; 
CREATE TABLE rcra.hhsm_basic( 
epa_handler_id VARCHAR,
activity_location VARCHAR,
source_type VARCHAR,
sequence_number BIGINT,
reason_for_notification VARCHAR,
hsm_effective_date DATE,
hsm_fa VARCHAR
);

--- hhsm_waste_code

DROP TABLE IF EXISTS rcra.hhsm_waste_code; 
CREATE TABLE rcra.hhsm_waste_code( 
epa_handler_id VARCHAR,
activity_location VARCHAR,
source_type VARCHAR,
sequence_number BIGINT,
hsm_sequence_number BIGINT,
waste_code_owner VARCHAR,
waste_code VARCHAR
);

--- hother_permit

DROP TABLE IF EXISTS rcra.hother_permit; 
CREATE TABLE rcra.hother_permit( 
epa_handler_id VARCHAR,
activity_location VARCHAR,
source_type VARCHAR,
handler_sequence_number BIGINT,
other_permit_number VARCHAR,
other_permit_type_owner VARCHAR,
other_permit_type VARCHAR,
other_permit_description VARCHAR
);

--- howner_operator

DROP TABLE IF EXISTS rcra.howner_operator; 
CREATE TABLE rcra.howner_operator( 
epa_handler_id VARCHAR,
activity_location VARCHAR,
source_type VARCHAR,
handler_sequence_number BIGINT,
owner_operator_sequence_number BIGINT,
owner_operator_indicator VARCHAR,
owner_operator_name VARCHAR,
owner_operator_type VARCHAR,
date_became_current DATE,
date_ended_current DATE,
owner_operator_street_1 VARCHAR,
owner_operator_street_2 VARCHAR,
owner_operator_city VARCHAR,
owner_operator_state VARCHAR,
owner_operator_country VARCHAR,
owner_operator_zip_code VARCHAR,
owner_operator_phone VARCHAR,
owner_operator_street_number VARCHAR
);

--- hother_id

DROP TABLE IF EXISTS rcra.hother_id; 
CREATE TABLE rcra.hother_id( 
epa_handler_id VARCHAR,
activity_location VARCHAR,
other_id VARCHAR,
same_facility VARCHAR,
relationship_owner VARCHAR,
relationship VARCHAR
);

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

--- hreport_univ

DROP TABLE IF EXISTS rcra.hreport_univ; 
CREATE TABLE rcra.hreport_univ( 
epa_handler_id VARCHAR,
activity_location VARCHAR,
source_type VARCHAR,
handler_sequence_number BIGINT,
current_site_name VARCHAR,
non_notifier VARCHAR,
receive_date DATE,
reporting_cycle_year BIGINT,
accessibility VARCHAR,
region VARCHAR,
state VARCHAR,
extract_flag VARCHAR,
active_site_indicator VARCHAR,
location_street_number VARCHAR,
location_street_1 VARCHAR,
location_street_2 VARCHAR,
location_city VARCHAR,
location_state VARCHAR,
location_zip_code VARCHAR,
county_code VARCHAR,
county_name VARCHAR,
country_code VARCHAR,
state_district_owner VARCHAR,
state_district VARCHAR,
land_type VARCHAR,
mailing_street_number VARCHAR,
mailing_street_1 VARCHAR,
mailing_street_2 VARCHAR,
mailing_city VARCHAR,
mailing_state VARCHAR,
mailing_zip_code VARCHAR,
mailing_country VARCHAR,
contact_name VARCHAR,
contact_street_no VARCHAR,
contact_street_1 VARCHAR,
contact_street_2 VARCHAR,
contact_city VARCHAR,
contact_state VARCHAR,
contact_zip VARCHAR,
contact_country VARCHAR,
contact_phone_number_and_extension VARCHAR,
contact_fax VARCHAR,
contact_email_address VARCHAR,
contact_title VARCHAR,
owner_name VARCHAR,
owner_type VARCHAR,
owner_sequence_number BIGINT,
operator_name VARCHAR,
operator_type VARCHAR,
operator_sequence_number BIGINT,
naics_code_1 VARCHAR,
naics_code_2 VARCHAR,
naics_code_3 VARCHAR,
naics_code_4 VARCHAR,
in_handler_universes VARCHAR,
in_a_universe VARCHAR,
federal_waste_generator_code_owner VARCHAR,
federal_waste_generator_code VARCHAR,
state_waste_generator_code_owner VARCHAR,
state_waste_generator_code VARCHAR,
generator_status_universe VARCHAR,
short_term_generator VARCHAR,
importer_activity VARCHAR,
mixed_waste_generator VARCHAR,
transporter_activity VARCHAR,
transfer_facility VARCHAR,
recycler_activity VARCHAR,
onsite_burner_exemption VARCHAR,
furnace_exemption VARCHAR,
underground_injection_activity VARCHAR,
receives_waste_from_off_site VARCHAR,
universal_waste VARCHAR,
universal_waste_destination_facility VARCHAR,
used_oil_universe VARCHAR,
federal_universal_waste VARCHAR,
active_site_federally_regulated_tsdf VARCHAR,
active_site_converter_tsdf VARCHAR,
active_site_state_regulated_tsdf VARCHAR,
federal_indicator VARCHAR,
hsm_ VARCHAR,
operating_under_40_cfr_part_262_subpart_k VARCHAR,
commercial_tsd VARCHAR,
tsd_type VARCHAR,
gpra_permit_baseline VARCHAR,
gpra_renewals_baseline VARCHAR,
permit_renewal_workload VARCHAR,
permit_workload_universe VARCHAR,
permit_progress_universe VARCHAR,
post_closure_workload_universe VARCHAR,
closure_workload_universe VARCHAR,
gpra_corrective_action_baseline VARCHAR,
corrective_action_workload_universe VARCHAR,
subject_to_corrective_action_universe VARCHAR,
non_tsdfs_where_rcra_corrective_action_has_been_imposed_univ VARCHAR,
tsdfs_potentially_subject_to_corrective_action_under_3004_u_ VARCHAR,
tsdfs_only_subject_to_corrective_action_under_discretionary_ VARCHAR,
ncaps_ranking VARCHAR,
environmental_control_indicator VARCHAR,
institutional_control_indicator VARCHAR,
human_exposure_indicator VARCHAR,
groundwater_controls_indicator VARCHAR,
operating_tsdf_universe VARCHAR,
full_enforcement_universe VARCHAR,
snc_universe VARCHAR,
unaddressed_snc VARCHAR,
addressed_snc VARCHAR,
snc_with_compliance_schedule VARCHAR,
financial_assurance_required VARCHAR,
handler_date_of_last_change DATE
);

--- hstate_activity

DROP TABLE IF EXISTS rcra.hstate_activity; 
CREATE TABLE rcra.hstate_activity( 
epa_handler_id VARCHAR,
activity_location VARCHAR,
source_type VARCHAR,
handler_sequence_number BIGINT,
state_activity_type_owner VARCHAR,
state_activity_type VARCHAR
);

--- huniversal_waste

DROP TABLE IF EXISTS rcra.huniversal_waste; 
CREATE TABLE rcra.huniversal_waste( 
epa_handler_id VARCHAR,
activity_location VARCHAR,
source_type VARCHAR,
handler_sequence_number BIGINT,
universal_waste_type_owner VARCHAR,
universal_waste_type VARCHAR,
accumulated VARCHAR,
generated VARCHAR
);

--- huniverse_detail

DROP TABLE IF EXISTS rcra.huniverse_detail; 
CREATE TABLE rcra.huniverse_detail( 
epa_handler_id VARCHAR,
activity_location VARCHAR,
post_closure_workload_land_disposal VARCHAR,
post_closure_workload_incinerator VARCHAR,
post_closure_workload_boilers_and_industrial_furnaces VARCHAR,
post_closure_workload_storage VARCHAR,
post_closure_workload_treatment VARCHAR,
permit_progress_land_disposal VARCHAR,
permit_progress_incinerator VARCHAR,
permit_progress_boilers_and_industrial_furnaces VARCHAR,
permit_progress_storage VARCHAR,
permit_progress_treatment VARCHAR,
closure_workload_land_disposal VARCHAR,
closure_workload_incinerator VARCHAR,
closure_workload_boilers_and_industrial_furnaces VARCHAR,
closure_workload_storage VARCHAR,
closure_workload_treatment VARCHAR,
permit_workload_land_disposal VARCHAR,
permit_workload_incinerator VARCHAR,
permit_workload_boilers_and_industrial_furnaces VARCHAR,
permit_workload_storage VARCHAR,
permit_workload_treatment VARCHAR,
full_enforcement_land_disposal VARCHAR,
full_enforcement_incinerator VARCHAR,
full_enforcement_boilers_and_industrial_furnaces VARCHAR,
full_enforcement_storage VARCHAR,
full_enforcement_treatment VARCHAR,
operating_tsdf_land_disposal VARCHAR,
operating_tsdf_incinerator VARCHAR,
operating_tsdf_boilers_and_industrial_furnaces VARCHAR,
operating_tsdf_storage VARCHAR,
operating_tsdf_treatment VARCHAR,
used_oil_transporter VARCHAR,
used_oil_transfer_facility VARCHAR,
used_oil_processor VARCHAR,
used_oil_refiner VARCHAR,
used_oil_burner VARCHAR,
used_oil_market_burner VARCHAR,
used_oil_specification_marketer VARCHAR,
active_site_handler_activities VARCHAR,
active_sitefederally_regulated_activities VARCHAR,
active_site_corrective_action_workload VARCHAR,
active_site_converter_activities VARCHAR,
active_site_state_activities VARCHAR,
active_site_federally_regulated_land_disposal VARCHAR,
active_site_federally_regulated_incinerator VARCHAR,
active_site_federally_regulated_boilers_and_industrial_furna VARCHAR,
active_site_federally_regulated_storage VARCHAR,
active_site_federally_regulated_treatment VARCHAR,
active_site_state_regulated_land_disposal VARCHAR,
active_site_state_regulated_incinerator VARCHAR,
active_site_state_regulated_boilers_and_industrial_furnaces VARCHAR,
active_site_state_regulated_storage VARCHAR,
active_site_state_regulated_treatment VARCHAR,
active_site_state_regulated_waste_generator VARCHAR,
active_site_state_regulated_universal_waste VARCHAR,
active_site_state_regulated_activity VARCHAR,
active_site_converter_land_disposal VARCHAR,
active_site_converter_incinerator VARCHAR,
active_site_converter_boilers_and_industrial_furnaces VARCHAR,
active_site_converter_storage VARCHAR,
active_site_converter_treatment VARCHAR,
permit_renewal_land_disposal VARCHAR,
permit_renewal_incinerator VARCHAR,
permit_renewal_boilers_and_industrial_furnaces VARCHAR,
permit_renewal_storage VARCHAR,
permit_renewal_treatment VARCHAR,
post_closure_workload_solid_waste_management_unit VARCHAR,
permit_progress_solid_waste_management_unit VARCHAR,
closure_workload_solid_waste_management_unit VARCHAR,
permit_workload_solid_waste_management_unit VARCHAR,
full_enforcement_solid_waste_management_unit VARCHAR,
operating_tsdf_solid_waste_management_unit VARCHAR,
active_site_federally_regulated_solid_waste_management_unit VARCHAR,
active_site_state_regulated_solid_waste_management_unit VARCHAR,
active_site_converter_solid_waste_management_unit VARCHAR,
permit_renewal_solid_waste_management_unit VARCHAR
);

--- hwaste_code

DROP TABLE IF EXISTS rcra.hwaste_code; 
CREATE TABLE rcra.hwaste_code( 
epa_handler_id VARCHAR,
activity_location VARCHAR,
source_type VARCHAR,
handler_sequence_number BIGINT,
hazardous_waste_code_owner VARCHAR,
hazardous_waste_code VARCHAR
);

--- lu_country

DROP TABLE IF EXISTS rcra.lu_country; 
CREATE TABLE rcra.lu_country( 
country_code VARCHAR,
country_name VARCHAR,
country_code_active_status VARCHAR
);

--- lu_county

DROP TABLE IF EXISTS rcra.lu_county; 
CREATE TABLE rcra.lu_county( 
county_code VARCHAR,
county_name VARCHAR,
county_code_active_status VARCHAR
);

--- lu_foreign_state

DROP TABLE IF EXISTS rcra.lu_foreign_state; 
CREATE TABLE rcra.lu_foreign_state( 
state_code VARCHAR,
state_name VARCHAR,
country_code VARCHAR
);

--- lu_generator_status

DROP TABLE IF EXISTS rcra.lu_generator_status; 
CREATE TABLE rcra.lu_generator_status( 
generator_status_owner VARCHAR,
generator_status_code VARCHAR,
generator_status_description VARCHAR,
generator_status_active_status VARCHAR
);

--- lu_hsm_facility_code

DROP TABLE IF EXISTS rcra.lu_hsm_facility_code; 
CREATE TABLE rcra.lu_hsm_facility_code( 
hsm_facility_code_owner VARCHAR,
hsm_facility_code VARCHAR,
hsm_facility_description VARCHAR,
hsm_facility_active_status VARCHAR
);

--- lu_naics

DROP TABLE IF EXISTS rcra.lu_naics; 
CREATE TABLE rcra.lu_naics( 
naics_owner VARCHAR,
naics_code VARCHAR,
naics_description VARCHAR,
naics_active_status VARCHAR,
naics_cycle VARCHAR
);

--- lu_other_permit

DROP TABLE IF EXISTS rcra.lu_other_permit; 
CREATE TABLE rcra.lu_other_permit( 
other_permit_owner VARCHAR,
other_permit_type VARCHAR,
other_permit_description VARCHAR,
other_permit_active_status VARCHAR
);

--- lu_relationship

DROP TABLE IF EXISTS rcra.lu_relationship; 
CREATE TABLE rcra.lu_relationship( 
relationship_owner VARCHAR,
relationship VARCHAR,
relationship_description VARCHAR,
relationship_active_status VARCHAR
);

--- lu_state

DROP TABLE IF EXISTS rcra.lu_state; 
CREATE TABLE rcra.lu_state( 
postal_code VARCHAR,
state_name VARCHAR,
region VARCHAR
);

--- lu_state_activity

DROP TABLE IF EXISTS rcra.lu_state_activity; 
CREATE TABLE rcra.lu_state_activity( 
state_activity_owner VARCHAR,
state_activity_code VARCHAR,
state_activity_description VARCHAR,
state_activity_active_status VARCHAR
);

--- lu_state_district

DROP TABLE IF EXISTS rcra.lu_state_district; 
CREATE TABLE rcra.lu_state_district( 
state_district_owner VARCHAR,
state_district_code VARCHAR,
state_district_description VARCHAR,
state_district_active_status VARCHAR
);

--- lu_universal_waste

DROP TABLE IF EXISTS rcra.lu_universal_waste; 
CREATE TABLE rcra.lu_universal_waste( 
universal_waste_owner VARCHAR,
universal_waste_code VARCHAR,
universal_waste_description VARCHAR,
universal_waste_active_status VARCHAR
);

--- lu_waste_code

DROP TABLE IF EXISTS rcra.lu_waste_code; 
CREATE TABLE rcra.lu_waste_code( 
waste_code_owner VARCHAR,
waste_code VARCHAR,
code_type VARCHAR,
waste_code_description VARCHAR,
waste_code_active_status VARCHAR,
br_waste_code_active_status VARCHAR
);

--- pseries

DROP TABLE IF EXISTS rcra.pseries; 
CREATE TABLE rcra.pseries( 
epa_handler_id VARCHAR,
series_sequence_number BIGINT,
series_name VARCHAR,
responsible_owner VARCHAR,
responsible_person VARCHAR
);

--- pevent

DROP TABLE IF EXISTS rcra.pevent; 
CREATE TABLE rcra.pevent( 
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

DROP TABLE IF EXISTS rcra.punit; 
CREATE TABLE rcra.punit( 
epa_handler_id VARCHAR,
process_unit_sequence_number BIGINT,
process_unit_name VARCHAR
);

--- punit_detail

DROP TABLE IF EXISTS rcra.punit_detail; 
CREATE TABLE rcra.punit_detail( 
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

DROP TABLE IF EXISTS rcra.pln_event_unit_detail; 
CREATE TABLE rcra.pln_event_unit_detail( 
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

DROP TABLE IF EXISTS rcra.plu_permit_event_code; 
CREATE TABLE rcra.plu_permit_event_code( 
permit_event_code_owner VARCHAR,
permit_event_code VARCHAR,
permit_event_code_active_status VARCHAR,
event_description VARCHAR
);

--- plu_process_code

DROP TABLE IF EXISTS rcra.plu_process_code; 
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

DROP TABLE IF EXISTS rcra.plu_unit_of_measure; 
CREATE TABLE rcra.plu_unit_of_measure( 
unit_of_measure_owner VARCHAR,
unit_of_measure_type VARCHAR,
unit_of_measure_active_status VARCHAR,
unit_of_measure_description VARCHAR,
unit_of_measure_short_description VARCHAR
);

--- pln_unit_detail_waste

DROP TABLE IF EXISTS rcra.pln_unit_detail_waste; 
CREATE TABLE rcra.pln_unit_detail_waste( 
handler_id VARCHAR,
unit_sequence BIGINT,
unit_detail_sequence BIGINT,
waste_code VARCHAR,
waste_code_owner VARCHAR
);

--- plu_legal_operating_status

DROP TABLE IF EXISTS rcra.plu_legal_operating_status; 
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
tsdfs_potentially_subject_to_corrective_action_under_3004_u_ VARCHAR,
tsdfs_only_subject_to_corrective_action_under_discretionary_ VARCHAR,
non_tsdfs_where_rcra_corrective_action_has_been_imposed VARCHAR,
_gpra_permit_accomplished VARCHAR,
active_site_federally_regulated_tsdf VARCHAR,
active_site_converter_tsdf VARCHAR,
active_site_state_regulated_tsdf VARCHAR,
permit_renewal_workload VARCHAR
);

--- br_reporting

DROP TABLE IF EXISTS rcra.br_reporting; 
CREATE TABLE rcra.br_reporting( 
handler_id VARCHAR,
activity_location VARCHAR,
source_type VARCHAR,
sequence_number BIGINT,
hazardous_waste_page_number VARCHAR,
hazardous_waste_sub_page_number VARCHAR,
br_form VARCHAR,
management_location VARCHAR,
report_cycle VARCHAR,
state VARCHAR,
state_name VARCHAR,
region VARCHAR,
handler_name VARCHAR,
location_street_number VARCHAR,
location_street_1 VARCHAR,
location_street_2 VARCHAR,
location_city VARCHAR,
location_state VARCHAR,
location_zip VARCHAR,
county_code VARCHAR,
county_name VARCHAR,
state_district VARCHAR,
generator_id_included_in_nbr VARCHAR,
generator_waste_stream_included_in_nbr VARCHAR,
manager_id_included_in_nbr VARCHAR,
manager_waste_stream_included_in_nbr VARCHAR,
shipper_id_included_in_nbr VARCHAR,
shipper_waste_stream_included_in_nbr VARCHAR,
receiver_id_included_in_nbr VARCHAR,
receiver_waste_stream_included_in_nbr VARCHAR,
waste_description VARCHAR,
primary_naics VARCHAR,
source_code VARCHAR,
form_code VARCHAR,
management_method VARCHAR,
federal_waste_flag VARCHAR,
wastewater_characteristic_indicator VARCHAR,
generation_tons FLOAT,
managed_tons FLOAT,
shipped_tons FLOAT,
received_tons FLOAT,
receiver_id VARCHAR,
receiver_state VARCHAR,
receiver_state_name VARCHAR,
receiver_region VARCHAR,
shipper_id VARCHAR,
shipper_state VARCHAR,
shipper_state_name VARCHAR,
shipper_region VARCHAR,
waste_minimization_code VARCHAR,
waste_code_group VARCHAR
);

--- bgm_waste_code

DROP TABLE IF EXISTS rcra.bgm_waste_code; 
CREATE TABLE rcra.bgm_waste_code( 
handler_id VARCHAR,
activity_location VARCHAR,
source_type VARCHAR,
sequence_number BIGINT,
hazardous_waste_page_number BIGINT,
waste_code_owner VARCHAR,
waste_code VARCHAR
);

--- bwr_waste_code

DROP TABLE IF EXISTS rcra.bwr_waste_code; 
CREATE TABLE rcra.bwr_waste_code( 
handler_id VARCHAR,
activity_location VARCHAR,
source_type VARCHAR,
sequence_number BIGINT,
hazardous_waste_page_number BIGINT,
hazardous_waste_sub_page_number BIGINT,
waste_code_owner VARCHAR,
waste_code VARCHAR
);

--- gis

DROP TABLE IF EXISTS rcra.gis; 
CREATE TABLE rcra.gis( 
handler_id VARCHAR,
gis_owner VARCHAR,
gis_sequence_number BIGINT,
unit_sequence_number BIGINT,
area_sequence_number BIGINT,
area_acreage FLOAT,
area_source_owner VARCHAR,
area_source_code VARCHAR,
area_source_date DATE,
data_collection_date DATE,
horizontal_acc_measure BIGINT,
source_map_scale_number BIGINT,
coordinate_data_owner VARCHAR,
coordinate_data_code VARCHAR,
geographic_reference_point_owner VARCHAR,
geographic_reference_point_code VARCHAR,
geometric_owner VARCHAR,
geometric_code VARCHAR,
horizontal_collection_owner VARCHAR,
horizontal_collection_code VARCHAR,
horizontal_reference_owner VARCHAR,
horizontal_reference_code VARCHAR,
verification_method_owner VARCHAR,
verification_method_code VARCHAR
);

--- gis_lat_long

DROP TABLE IF EXISTS rcra.gis_lat_long; 
CREATE TABLE rcra.gis_lat_long( 
handler_id VARCHAR,
gis_owner VARCHAR,
gis_sequence_number BIGINT,
gis_latitude_longitude_sequence_number BIGINT,
latitude_measure FLOAT,
longitude_measure FLOAT
);

--- lu_area_source

DROP TABLE IF EXISTS rcra.lu_area_source; 
CREATE TABLE rcra.lu_area_source( 
owner VARCHAR,
area_source_code VARCHAR,
area_source_code_description VARCHAR,
active_status VARCHAR
);

--- lu_coordinate

DROP TABLE IF EXISTS rcra.lu_coordinate; 
CREATE TABLE rcra.lu_coordinate( 
owner VARCHAR,
coordinate_data_code VARCHAR,
coordinate_data_description VARCHAR,
active_status VARCHAR
);

--- lu_geographic_reference

DROP TABLE IF EXISTS rcra.lu_geographic_reference; 
CREATE TABLE rcra.lu_geographic_reference( 
owner VARCHAR,
geographic_reference_point_code VARCHAR,
geographic_reference_point_description VARCHAR,
active_status VARCHAR
);

--- lu_geometric

DROP TABLE IF EXISTS rcra.lu_geometric; 
CREATE TABLE rcra.lu_geometric( 
owner VARCHAR,
geometric_code VARCHAR,
geometric_description VARCHAR,
active_status VARCHAR
);

--- lu_horizontal_collection

DROP TABLE IF EXISTS rcra.lu_horizontal_collection; 
CREATE TABLE rcra.lu_horizontal_collection( 
owner VARCHAR,
horizontal_collection_code VARCHAR,
horizontal_collection_description VARCHAR,
active_status VARCHAR
);

--- lu_horizontal_reference

DROP TABLE IF EXISTS rcra.lu_horizontal_reference; 
CREATE TABLE rcra.lu_horizontal_reference( 
owner VARCHAR,
horizontal_reference_code VARCHAR,
horizontal_reference_description VARCHAR,
active_status VARCHAR
);

--- lu_verification

DROP TABLE IF EXISTS rcra.lu_verification; 
CREATE TABLE rcra.lu_verification( 
owner VARCHAR,
verification_method_code VARCHAR,
verification_method_description VARCHAR,
active_status VARCHAR
);

