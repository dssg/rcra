#!/bin/bash -xv

RCRA_DIR=$1

psql -f import/rcra/create_table_gis.sql

echo loading gis into the database ...
cat $RCRA_DIR/gis/gis.csv | psql -c '\COPY rcra.gis FROM STDIN WITH CSV HEADER'
echo gis has been loaded into the database.

echo loading gis_lat_long into the database ...
cat $RCRA_DIR/gis/gis_lat_long.csv | psql -c '\COPY rcra.gis_lat_long FROM STDIN WITH CSV HEADER'
echo gis_lat_long has been loaded into the database.

echo loading lu_area_source into the database ...
cat $RCRA_DIR/gis/lu_area_source.csv | psql -c '\COPY rcra.lu_area_source FROM STDIN WITH CSV HEADER'
echo lu_area_source has been loaded into the database.

echo loading lu_coordinate into the database ...
cat $RCRA_DIR/gis/lu_coordinate.csv | psql -c '\COPY rcra.lu_coordinate FROM STDIN WITH CSV HEADER'
echo lu_coordinate has been loaded into the database.

echo loading lu_geographic_reference into the database ...
cat $RCRA_DIR/gis/lu_geographic_reference.csv | psql -c '\COPY rcra.lu_geographic_reference FROM STDIN WITH CSV HEADER'
echo lu_geographic_reference has been loaded into the database.

echo loading lu_geometric into the database ...
cat $RCRA_DIR/gis/lu_geometric.csv | psql -c '\COPY rcra.lu_geometric FROM STDIN WITH CSV HEADER'
echo lu_geometric has been loaded into the database.

echo loading lu_horizontal_collection into the database ...
cat $RCRA_DIR/gis/lu_horizontal_collection.csv | psql -c '\COPY rcra.lu_horizontal_collection FROM STDIN WITH CSV HEADER'
echo lu_horizontal_collection has been loaded into the database.

echo loading lu_horizontal_reference into the database ...
cat $RCRA_DIR/gis/lu_horizontal_reference.csv | psql -c '\COPY rcra.lu_horizontal_reference FROM STDIN WITH CSV HEADER'
echo lu_horizontal_reference has been loaded into the database.

echo loading lu_verification into the database ...
cat $RCRA_DIR/gis/lu_verification.csv | psql -c '\COPY rcra.lu_verification FROM STDIN WITH CSV HEADER'
echo lu_verification has been loaded into the database.

