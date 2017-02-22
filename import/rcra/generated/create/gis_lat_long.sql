--- gis_lat_long

DROP TABLE IF EXISTS rcra.gis_lat_long; 
CREATE TABLE rcra.gis_lat_long( 
handler_id VARCHAR,
gis_owner VARCHAR,
gis_sequence_number BIGINT,
gis_latitude_longitude_sequence_number BIGINT,
latitude_measure FLOAT,
longitude_measure FLOAT
);

