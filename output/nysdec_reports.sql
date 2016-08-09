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
