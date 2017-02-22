--- lu_verification

DROP TABLE IF EXISTS rcra.lu_verification; 
CREATE TABLE rcra.lu_verification( 
owner VARCHAR,
verification_method_code VARCHAR,
verification_method_description VARCHAR,
active_status VARCHAR
);

