#!/bin/bash -xv

RCRA_DIR=$1
echo loading gis into the database ...
$RCRA_DIR/GIS/gis.csv | psql -c '\COPY rcra.gis FROM STDIN WITH CSV HEADER'
echo rcra.gis has been loaded into the database.

echo loading gis_lat_long into the database ...
$RCRA_DIR/GIS/gis_lat_long.csv | psql -c '\COPY rcra.gis_lat_long FROM STDIN WITH CSV HEADER'
echo rcra.gis_lat_long has been loaded into the database.

echo loading lu_area_source into the database ...
$RCRA_DIR/GIS/lu_area_source.csv | psql -c '\COPY rcra.lu_area_source FROM STDIN WITH CSV HEADER'
echo rcra.lu_area_source has been loaded into the database.

echo loading lu_coordinate into the database ...
$RCRA_DIR/GIS/lu_coordinate.csv | psql -c '\COPY rcra.lu_coordinate FROM STDIN WITH CSV HEADER'
echo rcra.lu_coordinate has been loaded into the database.

echo loading lu_geographic_reference into the database ...
$RCRA_DIR/GIS/lu_geographic_reference.csv | psql -c '\COPY rcra.lu_geographic_reference FROM STDIN WITH CSV HEADER'
echo rcra.lu_geographic_reference has been loaded into the database.

echo loading lu_geometric into the database ...
$RCRA_DIR/GIS/lu_geometric.csv | psql -c '\COPY rcra.lu_geometric FROM STDIN WITH CSV HEADER'
echo rcra.lu_geometric has been loaded into the database.

echo loading lu_horizontal_collection into the database ...
$RCRA_DIR/GIS/lu_horizontal_collection.csv | psql -c '\COPY rcra.lu_horizontal_collection FROM STDIN WITH CSV HEADER'
echo rcra.lu_horizontal_collection has been loaded into the database.

echo loading lu_horizontal_reference into the database ...
$RCRA_DIR/GIS/lu_horizontal_reference.csv | psql -c '\COPY rcra.lu_horizontal_reference FROM STDIN WITH CSV HEADER'
echo rcra.lu_horizontal_reference has been loaded into the database.

echo loading lu_verification into the database ...
$RCRA_DIR/GIS/lu_verification.csv | psql -c '\COPY rcra.lu_verification FROM STDIN WITH CSV HEADER'
echo rcra.lu_verification has been loaded into the database.

