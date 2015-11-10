CREATE SCHEMA IF NOT EXISTS import;
 
DROP TABLE IF EXISTS import.frs_program_links;
 
CREATE TABLE import.frs_program_links (
       registry_id BIGINT,
       pgm_sys_acrnm VARCHAR(8),
       pgm_sys_id VARCHAR(15)
);

DROP TABLE IF EXISTS import.frs_facilities;

CREATE TABLE import.frs_facilities (
       fac_name VARCHAR,
       fac_street VARCHAR,
       fac_city VARCHAR,
       fac_state VARCHAR,
       fac_zip VARCHAR,
       registry_id BIGINT,
       fac_county VARCHAR,
       fac_epa_region VARCHAR
);
