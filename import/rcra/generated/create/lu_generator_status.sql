--- lu_generator_status

DROP TABLE IF EXISTS rcra.lu_generator_status; 
CREATE TABLE rcra.lu_generator_status( 
generator_status_owner VARCHAR,
generator_status_code VARCHAR,
generator_status_description VARCHAR,
generator_status_active_status VARCHAR
);

