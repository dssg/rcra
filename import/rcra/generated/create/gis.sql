--- gis

DROP TABLE IF EXISTS rcra.gis; 
CREATE TABLE rcra.gis( 
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

