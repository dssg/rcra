import pandas as pd

raw_sql = """
select rcra_nr_a as rcra_id, 
    reporting_year,
    
    trade_secret_indicator = 'YES' as trade_secret,
    sanitized_indicator = 'YES' as sanitized,
    produce_the_chemical = 'YES' as produce_chemical,
    import_the_chemical = 'YES' as import_chemical,
    sale_or_distribution = 'YES' as sale_or_distribution,
    as_a_byproduct = 'YES' as byproduct,
    repackaging = 'YES' as repackaging, 

    as_a_manufactured_impurity = 'true' as manufactured_impurity,
    as_a_reactant = 'true' as reactant,
    as_a_formulation_component = 'true' as formulation_component,
    as_an_article_component = 'true' as article_component,
    as_a_process_impurity = 'true' as process_impurity,
    as_a_chemical_processing_aid = 'true' as chemical_processing_aid,
    as_a_manufacturing_aid = 'YES' as manufacturing_aid,
    ancillary_or_other_use = 'true' as ancillary_or_other_use,

    total_stack_air_emissions,

    CASE WHEN isnumeric(total_number_of_receiving_streams) = 't' THEN total_number_of_receiving_streams ELSE '0' END 
       as total_number_of_receiving_streams,
    
    CASE WHEN isnumeric(total_surface_water_discharge) = 't' THEN total_surface_water_discharge ELSE '0' END
       as total_surface_water_discharge,

    total_underground_injection,
    total_rcra_subtitle_c_landfills,
    total_land_treatment,
    total_surface_impoundments,
    total_other_disposal,
    storage_only,
    other_landfills,

    CASE WHEN isnumeric(transfers_to_waste_broker_for_disposal) = 't' THEN transfers_to_waste_broker_for_disposal ELSE '0' END                                          as transfers_to_waste_broker_for_disposal, 
    
    energy_recovery_onsite_current_year,
    total_rcra_c_surface_impoundments,
    total_other_surface_impoundments,

from tri.type_1 
   where rcra_nr_a is not null 
   and reporting_year < extract(year from '{today}')
"""
