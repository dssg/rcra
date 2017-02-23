drop table if exists output.handlers;

create table output.handlers as (

select 
    epa_handler_id as rcra_id,
    receive_date,
    current_site_name,
    state_district,

    location_street_number,
    location_street_1,
    location_street_2,
    location_city,
    location_state,
    hhandler.location_zip_code,

    mailing_street_number,
    mailing_street_1,
    mailing_street_2,
    mailing_city,
    mailing_state,
    mailing_zip_code,

    non_notifier = 'X'  as handler_non_notifier,
    non_notifier = 'O'  as handler_non_notifier_former,
    non_notifier = 'E'  as handler_non_notifier_exempt,

    hhandler.location_zip_code = mailing_zip_code as handler_location_eq_mailing,
    
    federal_waste_generator_code = 'N'  as handler_not_generator,
    federal_waste_generator_code = '1'  as handler_lqg,
    federal_waste_generator_code = '2'  as handler_sqg,
    federal_waste_generator_code = '3'  as handler_cesqg,
    
    land_type = 'I'  as handler_land_type_tribal,
    land_type = 'P'  as handler_land_type_private,
    land_type = 'S'  as handler_land_type_state,
    land_type = 'C'  as handler_land_type_county,
    land_type = 'O'  as handler_land_type_other,
    land_type = 'D'  as handler_land_type_district,
    land_type = '-'  as handler_land_type_unknown,
    land_type = 'F'  as handler_land_type_federal,
    land_type = 'M'  as handler_land_type_municipal,

    short_term_generator = 'Y'  as handler_short_term_generator,

    importer_activity = 'Y'  as handler_importer_activity,
    
    mixed_waste_generator = 'Y'  as handler_mixed_waste_generator,
    
    transporter_activity = 'Y'  as handler_transporter_activity,
    
    transfer_facility = 'Y'  as handler_transfer_facility,
    tsd_activity = 'Y'  as handler_tsd_activity,
    recycler_activity = 'Y'  as handler_recycler_activity,
    
    onsite_burner_exemption = 'Y'  as handler_onsite_burner_exemption,
    furnace_exemption = 'Y'  as handler_furnace_exemption,
    underground_injection_activity = 'Y'  as handler_underground_injection_activity,
    receives_waste_from_off_site = 'Y'  as handler_receives_waste_from_off_site,
    universal_waste_destination_facility = 'Y'  as handler_universal_waste_destination_facility,
    
    used_oil_transporter = 'Y'  as handler_used_oil_transporter,
    used_oil_transfer_facility = 'Y'  as handler_used_oil_transfer_facility,
    used_oil_processor = 'Y'  as handler_used_oil_processor,
    used_oil_refiner = 'Y'  as handler_used_oil_refiner,
    used_oil_fuel_marketer_to_burner = 'Y'  as handler_used_oil_fuel_marketer_to_burner,
    used_oil_specification_marketer = 'Y'  as handler_used_oil_specification_marketer,
	
    under_40_cfr_part_262_subpart_k_as_a_college_or_university = 'Y'  as handler_university,
    under_40_cfr_part_262_subpart_k_as_a_teaching_hospital = 'Y'  as handler_teaching_hospital,
    under_40_cfr_part_262_subpart_k_as_a_non_profit_research_ins = 'Y'  as handler_nonprofit,

    withdrawal_from_40_cfr_part_262_subpart_k = 'Y'  as handler_withdrawal,
    include_in_national_report = 'Y'  as handler_include_in_br--,

from rcra.hhandler
join output.facilities on epa_handler_id = rcra_id
);

alter table output.handlers add handler_id serial primary key;

create index on output.handlers (rcra_id, receive_date);
