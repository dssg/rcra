CREATE SCHEMA IF NOT EXISTS frs;
 
DROP TABLE IF EXISTS frs.program_links;
 
CREATE TABLE frs.program_links (
       registry_id BIGINT,
       pgm_sys_acrnm VARCHAR,
       pgm_sys_id VARCHAR
);

DROP TABLE IF EXISTS frs.facilities;

CREATE TABLE frs.facilities (
       fac_name VARCHAR,
       fac_street VARCHAR,
       fac_city VARCHAR,
       fac_state VARCHAR,
       fac_zip VARCHAR,
       registry_id BIGINT,
       fac_county VARCHAR,
       fac_epa_region VARCHAR
);
