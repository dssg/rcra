--- lu_naics

DROP TABLE IF EXISTS rcra.lu_naics; 
CREATE TABLE rcra.lu_naics( 
naics_owner VARCHAR,
naics_code VARCHAR,
naics_description VARCHAR,
naics_active_status VARCHAR,
naics_cycle VARCHAR
);

