drop table if exists output.handlers;

create table output.handlers as (

select 
    epa_handler_id as rcra_id, receive_date, 
    non_notifier = 'X' as hhandler_non_notifier,
    non_notifier = 'O' as hhandler_non_notifier_former,
    non_notifier = 'E' as hhandler_non_notifier_exempt,

    location_zip_code,
    mailing_zip_code,
    
    federal_waste_generator_code = 'N' as hhandler_not_generator,
    federal_waste_generator_code = '1' as hhandler_lqg,
    federal_waste_generator_code = '2' as hhandler_sqg,
    federal_waste_generator_code = '3' as hhandler_cesqg,
    
    land_type = 'I' as hhandler_land_type_tribal,
    land_type = 'P' as hhandler_land_type_private,
    land_type = 'S' as hhandler_land_type_state,
    land_type = 'C' as hhandler_land_type_county,
    land_type = 'O' as hhandler_land_type_other,
    land_type = 'D' as hhandler_land_type_district,
    land_type = '-' as hhandler_land_type_unknown,
    land_type = 'F' as hhandler_land_type_federal,
    land_type = 'M' as hhandler_land_type_municipal,

    short_term_generator = 'Y' as hhandler_short_term_generator,

    importer_activity = 'Y' as hhandler_importer_activity,
    
    mixed_waste_generator = 'Y' as hhandler_mixed_waste_generator,
    
    transporter_activity = 'Y' as hhandler_transporter_activity,
    
    transfer_facility = 'Y' as hhandler_transfer_facility,
    tsd_activity = 'Y' as hhandler_tsd_activity,
    recycler_activity = 'Y' as hhandler_recycler_activity,
    
    onsite_burner_exemption = 'Y' as hhandler_onsite_burner_exemption,
    furnace_exemption = 'Y' as hhandler_furnace_exemption,
    underground_injection_activity = 'Y' as hhandler_underground_injection_activity,
    receives_waste_from_off_site = 'Y' as hhandler_receives_waste_from_off_site,
    universal_waste_destination_facility = 'Y' as hhandler_universal_waste_destination_facility,
    
    used_oil_transporter = 'Y' as hhandler_used_oil_transporter,
    used_oil_transfer_facility = 'Y' as hhandler_used_oil_transfer_facility,
    used_oil_processor = 'Y' as hhandler_used_oil_processor,
    used_oil_refiner = 'Y' as hhandler_used_oil_refiner,
    used_oil_fuel_marketer_to_burner = 'Y' as hhandler_used_oil_fuel_marketer_to_burner,
    used_oil_specification_marketer = 'Y' as hhandler_used_oil_specification_marketer,
	
    under_40_cfr_part_262_subpart_k_as_a_college_or_university = 'Y' as hhandler_university,
    under_40_cfr_part_262_subpart_k_as_a_teaching_hospital = 'Y' as hhandler_teaching_hospital,
    under_40_cfr_part_262_subpart_k_as_a_non__profit_research_insti = 'Y' as hhandler_nonprofit,
    
    withdrawal_from_40_cfr_part_262_subpart_k = 'Y' as hhandler_withdrawal,
    include_in_national_report = 'Y' as hhandler_include_in_br

from rcra.hhandler
);
