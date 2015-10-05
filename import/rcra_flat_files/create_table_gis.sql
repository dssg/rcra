--- gis

CREATE TABLE gis( 
handler_id VARCHAR,
gis_owner VARCHAR,
gis_sequence_number BIGINT,
unit_sequence_number BIGINT,
area_sequence_number BIGINT,
area_acreage FLOAT,
area_source_owner VARCHAR,
area_source_code VARCHAR,
area_source_date DATE,
data_collection_date DATE,
horizontal_acc_measure BIGINT,
source_map_scale_number BIGINT,
coordinate_data_owner VARCHAR,
coordinate_data_code VARCHAR,
geographic_reference_point_owner VARCHAR,
geographic_reference_point_code VARCHAR,
geometric_owner VARCHAR,
geometric_code VARCHAR,
horizontal_collection_owner VARCHAR,
horizontal_collection_code VARCHAR,
horizontal_reference_owner VARCHAR,
horizontal_reference_code VARCHAR,
verification_method_owner VARCHAR,
verification_method_code VARCHAR
);

--- gis_lat_long

CREATE TABLE gis_lat_long( 
handler_id VARCHAR,
gis_owner VARCHAR,
gis_sequence_number BIGINT,
gis_latitude_longitude_sequence_number BIGINT,
latitude_measure FLOAT,
longitude_measure FLOAT
);

--- lu_area_source

CREATE TABLE lu_area_source( 
owner VARCHAR,
area_source_code VARCHAR,
area_source_code_description VARCHAR,
active_status VARCHAR
);

--- lu_coordinate

CREATE TABLE lu_coordinate( 
owner VARCHAR,
coordinate_data_code VARCHAR,
coordinate_data_description VARCHAR,
active_status VARCHAR
);

--- lu_geographic_reference

CREATE TABLE lu_geographic_reference( 
owner VARCHAR,
geographic_reference_point_code VARCHAR,
geographic_reference_point_description VARCHAR,
active_status VARCHAR
);

--- lu_geometric

CREATE TABLE lu_geometric( 
owner VARCHAR,
geometric_code VARCHAR,
geometric_description VARCHAR,
active_status VARCHAR
);

--- lu_horizontal_collection

CREATE TABLE lu_horizontal_collection( 
owner VARCHAR,
horizontal_collection_code VARCHAR,
horizontal_collection_description VARCHAR,
active_status VARCHAR
);

--- lu_horizontal_reference

CREATE TABLE lu_horizontal_reference( 
owner VARCHAR,
horizontal_reference_code VARCHAR,
horizontal_reference_description VARCHAR,
active_status VARCHAR
);

--- lu_verification

CREATE TABLE lu_verification( 
owner VARCHAR,
verification_method_code VARCHAR,
verification_method_description VARCHAR,
active_status VARCHAR
);

