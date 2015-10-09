#!/bin/bash -xv

RCRA_DIR=$1

psql -f import/rcra/create_table_gis.sql

echo loading gis into the database ...
in2csv -e iso-8859-1 -f fixed -s $RCRA_DIR/gis_schema.csv $RCRA_DIR/gis.txt | psql -c '\COPY rcra.gis FROM STDIN WITH CSV HEADER'
echo gis has been loaded into the database.

echo loading gis_lat_long into the database ...
in2csv -e iso-8859-1 -f fixed -s $RCRA_DIR/gis_lat_long_schema.csv $RCRA_DIR/gis_lat_long.txt | psql -c '\COPY rcra.gis_lat_long FROM STDIN WITH CSV HEADER'
echo gis_lat_long has been loaded into the database.

echo loading lu_area_source into the database ...
in2csv -e iso-8859-1 -f fixed -s $RCRA_DIR/lu_area_source_schema.csv $RCRA_DIR/lu_area_source.txt | psql -c '\COPY rcra.lu_area_source FROM STDIN WITH CSV HEADER'
echo lu_area_source has been loaded into the database.

echo loading lu_coordinate into the database ...
in2csv -e iso-8859-1 -f fixed -s $RCRA_DIR/lu_coordinate_schema.csv $RCRA_DIR/lu_coordinate.txt | psql -c '\COPY rcra.lu_coordinate FROM STDIN WITH CSV HEADER'
echo lu_coordinate has been loaded into the database.

echo loading lu_geographic_reference into the database ...
in2csv -e iso-8859-1 -f fixed -s $RCRA_DIR/lu_geographic_reference_schema.csv $RCRA_DIR/lu_geographic_reference.txt | psql -c '\COPY rcra.lu_geographic_reference FROM STDIN WITH CSV HEADER'
echo lu_geographic_reference has been loaded into the database.

echo loading lu_geometric into the database ...
in2csv -e iso-8859-1 -f fixed -s $RCRA_DIR/lu_geometric_schema.csv $RCRA_DIR/lu_geometric.txt | psql -c '\COPY rcra.lu_geometric FROM STDIN WITH CSV HEADER'
echo lu_geometric has been loaded into the database.

echo loading lu_horizontal_collection into the database ...
in2csv -e iso-8859-1 -f fixed -s $RCRA_DIR/lu_horizontal_collection_schema.csv $RCRA_DIR/lu_horizontal_collection.txt | psql -c '\COPY rcra.lu_horizontal_collection FROM STDIN WITH CSV HEADER'
echo lu_horizontal_collection has been loaded into the database.

echo loading lu_horizontal_reference into the database ...
in2csv -e iso-8859-1 -f fixed -s $RCRA_DIR/lu_horizontal_reference_schema.csv $RCRA_DIR/lu_horizontal_reference.txt | psql -c '\COPY rcra.lu_horizontal_reference FROM STDIN WITH CSV HEADER'
echo lu_horizontal_reference has been loaded into the database.

echo loading lu_verification into the database ...
in2csv -e iso-8859-1 -f fixed -s $RCRA_DIR/lu_verification_schema.csv $RCRA_DIR/lu_verification.txt | psql -c '\COPY rcra.lu_verification FROM STDIN WITH CSV HEADER'
echo lu_verification has been loaded into the database.

