--- lu_waste_code

DROP TABLE IF EXISTS rcra.lu_waste_code; 
CREATE TABLE rcra.lu_waste_code( 
waste_code_owner VARCHAR,
waste_code VARCHAR,
code_type VARCHAR,
waste_code_description VARCHAR,
waste_code_active_status VARCHAR,
br_waste_code_active_status VARCHAR
);

