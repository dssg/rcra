--- hbasic

CREATE TABLE hbasic( 
epa_handler_id VARCHAR,
epa_facility_identification_code VARCHAR,
current_site_name VARCHAR,
region VARCHAR,
state VARCHAR
);

--- hcertification

CREATE TABLE hcertification( 
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

CREATE TABLE hhandler( 
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
under_40_cfr_part_262_subpart_k_as_a_non_profit_research_institute VARCHAR,
withdrawal_from_40_cfr_part_262_subpart_k VARCHAR,
include_in_national_report VARCHAR,
reporting_cycle_year BIGINT,
cdx_transaction_id VARCHAR
);

--- hnaics

CREATE TABLE hnaics( 
epa_handler_id VARCHAR,
activity_location VARCHAR,
source_type VARCHAR,
sequence_number BIGINT,
naics_sequence_number BIGINT,
naics_code_owner VARCHAR,
naics_code VARCHAR
);

--- hhsm_activity

CREATE TABLE hhsm_activity( 
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

CREATE TABLE hhsm_basic( 
epa_handler_id VARCHAR,
activity_location VARCHAR,
source_type VARCHAR,
sequence_number BIGINT,
reason_for_notification VARCHAR,
hsm_effective_date DATE,
hsm_fa VARCHAR
);

--- hhsm_waste_code

CREATE TABLE hhsm_waste_code( 
epa_handler_id VARCHAR,
activity_location VARCHAR,
source_type VARCHAR,
sequence_number BIGINT,
hsm_sequence_number BIGINT,
waste_code_owner VARCHAR,
waste_code VARCHAR
);

--- hother_permit

CREATE TABLE hother_permit( 
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

CREATE TABLE howner_operator( 
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

CREATE TABLE hother_id( 
epa_handler_id VARCHAR,
activity_location VARCHAR,
other_id VARCHAR,
same_facility VARCHAR,
relationship_owner VARCHAR,
relationship VARCHAR
);

--- hpart_a

CREATE TABLE hpart_a( 
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

CREATE TABLE hreport_univ( 
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
non_tsdfs_where_rcra_corrective_action_has_been_imposed_universe VARCHAR,
tsdfs_potentially_subject_to_corrective_action_under_3004_u_v_universe VARCHAR,
tsdfs_only_subject_to_corrective_action_under_discretionary_authorities_universe VARCHAR,
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

CREATE TABLE hstate_activity( 
epa_handler_id VARCHAR,
activity_location VARCHAR,
source_type VARCHAR,
handler_sequence_number BIGINT,
state_activity_type_owner VARCHAR,
state_activity_type VARCHAR
);

--- huniversal_waste

CREATE TABLE huniversal_waste( 
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

CREATE TABLE huniverse_detail( 
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
active_site_federally_regulated_boilers_and_industrial_furnaces_ VARCHAR,
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

CREATE TABLE hwaste_code( 
epa_handler_id VARCHAR,
activity_location VARCHAR,
source_type VARCHAR,
handler_sequence_number BIGINT,
hazardous_waste_code_owner VARCHAR,
hazardous_waste_code VARCHAR
);

--- lu_country

CREATE TABLE lu_country( 
country_code VARCHAR,
country_name VARCHAR,
country_code_active_status VARCHAR
);

--- lu_county

CREATE TABLE lu_county( 
county_code VARCHAR,
county_name VARCHAR,
county_code_active_status VARCHAR
);

--- lu_foreign_state

CREATE TABLE lu_foreign_state( 
state_code VARCHAR,
state_name VARCHAR,
country_code VARCHAR
);

--- lu_generator_status

CREATE TABLE lu_generator_status( 
generator_status_owner VARCHAR,
generator_status_code VARCHAR,
generator_status_description VARCHAR,
generator_status_active_status VARCHAR
);

--- lu_hsm_facility_code

CREATE TABLE lu_hsm_facility_code( 
hsm_facility_code_owner VARCHAR,
hsm_facility_code VARCHAR,
hsm_facility_description VARCHAR,
hsm_facility_active_status VARCHAR
);

--- lu_naics

CREATE TABLE lu_naics( 
naics_owner VARCHAR,
naics_code VARCHAR,
naics_description VARCHAR,
naics_active_status VARCHAR,
naics_cycle VARCHAR
);

--- lu_other_permit

CREATE TABLE lu_other_permit( 
other_permit_owner VARCHAR,
other_permit_type VARCHAR,
other_permit_description VARCHAR,
other_permit_active_status VARCHAR
);

--- lu_relationship

CREATE TABLE lu_relationship( 
relationship_owner VARCHAR,
relationship VARCHAR,
relationship_description VARCHAR,
relationship_active_status VARCHAR
);

--- lu_state

CREATE TABLE lu_state( 
postal_code VARCHAR,
state_name VARCHAR,
region VARCHAR
);

--- lu_state_activity

CREATE TABLE lu_state_activity( 
state_activity_owner VARCHAR,
state_activity_code VARCHAR,
state_activity_description VARCHAR,
state_activity_active_status VARCHAR
);

--- lu_state_district

CREATE TABLE lu_state_district( 
state_district_owner VARCHAR,
state_district_code VARCHAR,
state_district_description VARCHAR,
state_district_active_status VARCHAR
);

--- lu_universal_waste

CREATE TABLE lu_universal_waste( 
universal_waste_owner VARCHAR,
universal_waste_code VARCHAR,
universal_waste_description VARCHAR,
universal_waste_active_status VARCHAR
);

--- lu_waste_code

CREATE TABLE lu_waste_code( 
waste_code_owner VARCHAR,
waste_code VARCHAR,
code_type VARCHAR,
waste_code_description VARCHAR,
waste_code_active_status VARCHAR,
br_waste_code_active_status VARCHAR
);

