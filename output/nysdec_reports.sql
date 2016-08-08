
DROP TABLE IF EXISTS nysdec_reports.gm_all
CREATE TABLE nysdec_reports.gm_all AS
    SELECT a.*, b.state_waste_codes, c.epa_waste_codes FROM
            (SELECT *
            FROM nysdec_reports.gm1) a
        LEFT JOIN
            (SELECT handler_id,
                    hz_pg,
                    report_year,
                    array_agg(state_waste_code) as state_waste_codes
            FROM nysdec_reports.gm3
            GROUP BY handler_id, hz_pg, report_year) b
        ON a.handler_id = b.handler_id AND a.hz_pg = b.hz_pg AND a.report_year = b.report_year
        LEFT JOIN
            (SELECT handler_id,
                    hz_pg,
                    report_year,
                    array_agg(epa_waste_code) as epa_waste_codes
            FROM nysdec_reports.gm2
            GROUP BY handler_id, hz_pg, report_year) c
        ON a.handler_id = c.handler_id AND a.hz_pg = c.hz_pg AND a.report_year = c.report_year;




