-- merge the GM* tables
-- each line is a unique combination of HANDLER_ID, HZ_PG, and REPORT_YEAR

DROP TABLE IF EXISTS nysdec_reports.gm_combined;
CREATE TABLE nysdec_reports.gm_combined AS
    SELECT a.*, b.epa_waste_codes, c.state_waste_codes, d.management_methods as io_management_methods, d.io_tdr_ids, d.sum_io_tdr_qty, e.management_methods as sys_management_methods, e.sum_sys_tdr_qty FROM
            (SELECT *
            FROM nysdec_reports.gm1) a
        LEFT JOIN
            (SELECT handler_id,
                    hz_pg,
                    report_year,
                    array_agg(epa_waste_code) as epa_waste_codes
            FROM nysdec_reports.gm2
            GROUP BY handler_id, hz_pg, report_year) b 
        ON a.handler_id = b.handler_id AND a.hz_pg = b.hz_pg AND a.report_year = b.report_year
        LEFT JOIN
            (SELECT handler_id,
                    hz_pg,
                    report_year,
                    array_agg(state_waste_code) as state_waste_codes
            FROM nysdec_reports.gm3
            GROUP BY handler_id, hz_pg, report_year) c
        ON a.handler_id = c.handler_id AND a.hz_pg = c.hz_pg AND a.report_year = c.report_year
        LEFT JOIN
            (SELECT handler_id,
                    hz_pg,
                    report_year,
                    array_agg(management_method) as management_methods,
                    array_agg(io_tdr_id) as io_tdr_ids,
                    sum(io_tdr_qty) as sum_io_tdr_qty
            FROM nysdec_reports.gm4
            GROUP BY handler_id, hz_pg, report_year) d 
        ON a.handler_id = d.handler_id AND a.hz_pg = d.hz_pg AND a.report_year = d.report_year
        LEFT JOIN
            (SELECT handler_id,
                    hz_pg,
                    report_year,
                    array_agg(management_method) as management_methods,
                    sum(sys_tdr_qty) as sum_sys_tdr_qty
            FROM nysdec_reports.gm5
            GROUP BY handler_id, hz_pg, report_year) e 
        ON a.handler_id = e.handler_id AND a.hz_pg = e.hz_pg AND a.report_year = e.report_year;

-- convert gen_qty to pounds
        
ALTER TABLE nysdec_reports.gm_combined add gen_qty_lbs double precision;

do $$
    DECLARE POUNDS_IN_ONE_GALLON_OF_WATER double precision := 8.345404;
    DECLARE POUNDS_IN_KILO double precision := 2.20462;
    DECLARE POUNDS_IN_TON double precision := 2000;
    DECLARE POUNDS_IN_METRIC_TON double precision := 2204.62;
    DECLARE GALLONS_IN_LITER double precision := 0.264172;
    DECLARE GALLONS_IN_CUBIC_YARD double precision := 201.974;

    BEGIN
        update nysdec_reports.gm_combined 
        set gen_qty_lbs = case when unit_of_measure = '1' then gen_qty 
        when unit_of_measure = '2' then gen_qty * POUNDS_IN_TON
        when unit_of_measure = '3' then gen_qty * POUNDS_IN_KILO
        when unit_of_measure = '4' then gen_qty * POUNDS_IN_METRIC_TON
        when unit_of_measure = '5' and density_unit_of_measure = '1' then wst_density * gen_qty 
        when unit_of_measure = '5' and density_unit_of_measure = '2' then wst_density * POUNDS_IN_ONE_GALLON_OF_WATER * gen_qty
        when unit_of_measure = '6' and density_unit_of_measure = '1' then wst_density * gen_qty * GALLONS_IN_LITER
        when unit_of_measure = '6' and density_unit_of_measure = '2' then wst_density * POUNDS_IN_ONE_GALLON_OF_WATER * gen_qty * GALLONS_IN_LITER
        when unit_of_measure = '6' and density_unit_of_measure = '1' then wst_density * gen_qty * GALLONS_IN_CUBIC_YARD
        when unit_of_measure = '6' and density_unit_of_measure = '2' then wst_density * POUNDS_IN_ONE_GALLON_OF_WATER * gen_qty * GALLONS_IN_CUBIC_YARD
    end;
end $$;

-- merge the SI* tables
-- each line is a unique combination of HANDLER_ID and REPORT_YEAR

DROP TABLE IF EXISTS nysdec_reports.si_combined;
CREATE TABLE nysdec_reports.si_combined AS
    SELECT a.*, b.naics_codes, c.epa_waste_codes, d.state_waste_codes FROM 
            (SELECT *
            FROM nysdec_reports.si1) a
        LEFT JOIN
            (SELECT handler_id,
                    report_year,
                    array_agg(naics_code) as naics_codes
            FROM nysdec_reports.si3
            GROUP BY handler_id, report_year) b 
        ON a.handler_id = b.handler_id AND a.report_year = b.report_year
        LEFT JOIN
            (SELECT handler_id,
                    report_year,
                    array_agg(epa_waste_code) as epa_waste_codes
            FROM nysdec_reports.si4
            GROUP BY handler_id, report_year) c
        ON a.handler_id = c.handler_id AND a.report_year = c.report_year
        LEFT JOIN
            (SELECT handler_id,
                    report_year,
                    array_agg(state_waste_code) as state_waste_codes
            FROM nysdec_reports.si5
            GROUP BY handler_id, report_year) d 
        ON a.handler_id = d.handler_id AND a.report_year = d.report_year;

-- collapse the gm_combined table into handler_id-report_year observations

DROP TABLE IF EXISTS nysdec_reports.gm_combined_collapsed;
CREATE TABLE nysdec_reports.gm_combined_collapsed AS
    SELECT handler_id, report_year,
        array_agg(unit_of_measure) as units_of_measure,
        array_agg(wst_density) as wst_densities,
        array_agg(management_method) as management_methods,
        array_agg(source_code) as source_codes,
        bool_or(include_in_national_report='Y') as include_in_national_report,
        array_agg(description) as descriptions,
        array_agg(notes) as notes,
        bool_or(on_site_management='Y') as on_site_management,
        bool_or(off_site_shipment='Y') as off_site_shipment,
        anyarray_agg(epa_waste_codes) as epa_waste_codes,
        anyarray_agg(state_waste_codes) as state_waste_codes,
        anyarray_agg(io_management_methods) as io_management_methods,
        anyarray_agg(io_tdr_ids) as io_tdr_ids,
        sum(sum_io_tdr_qty) as sum_io_tdr_qty,
        anyarray_agg(sys_management_methods) as sys_management_methods,
        sum(sum_sys_tdr_qty) as sum_sys_tdr_qty,
        sum(gen_qty_lbs) as gen_qty_lbs
    FROM nysdec_reports.gm_combined
    GROUP BY handler_id, report_year;



