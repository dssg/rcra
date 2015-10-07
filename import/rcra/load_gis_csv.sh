#!/bin/bash -xv

psql -f drop_table_gis.sql
psql -f create_table_gis.sql

echo loading gis into the database ...
in2csv -e iso-8859-1 -f fixed -s gis_schema.csv /mnt/data/epa/RCRA_flat_files/gis.txt | psql -c '\COPY gis FROM STDIN WITH CSV HEADER'
echo gis has been loaded into the database.

echo loading gis_lat_long into the database ...
in2csv -e iso-8859-1 -f fixed -s gis_lat_long_schema.csv /mnt/data/epa/RCRA_flat_files/gis_lat_long.txt | psql -c '\COPY gis_lat_long FROM STDIN WITH CSV HEADER'
echo gis_lat_long has been loaded into the database.

echo loading lu_area_source into the database ...
in2csv -e iso-8859-1 -f fixed -s lu_area_source_schema.csv /mnt/data/epa/RCRA_flat_files/lu_area_source.txt | psql -c '\COPY lu_area_source FROM STDIN WITH CSV HEADER'
echo lu_area_source has been loaded into the database.

echo loading lu_coordinate into the database ...
in2csv -e iso-8859-1 -f fixed -s lu_coordinate_schema.csv /mnt/data/epa/RCRA_flat_files/lu_coordinate.txt | psql -c '\COPY lu_coordinate FROM STDIN WITH CSV HEADER'
echo lu_coordinate has been loaded into the database.

echo loading lu_geographic_reference into the database ...
in2csv -e iso-8859-1 -f fixed -s lu_geographic_reference_schema.csv /mnt/data/epa/RCRA_flat_files/lu_geographic_reference.txt | psql -c '\COPY lu_geographic_reference FROM STDIN WITH CSV HEADER'
echo lu_geographic_reference has been loaded into the database.

echo loading lu_geometric into the database ...
in2csv -e iso-8859-1 -f fixed -s lu_geometric_schema.csv /mnt/data/epa/RCRA_flat_files/lu_geometric.txt | psql -c '\COPY lu_geometric FROM STDIN WITH CSV HEADER'
echo lu_geometric has been loaded into the database.

echo loading lu_horizontal_collection into the database ...
in2csv -e iso-8859-1 -f fixed -s lu_horizontal_collection_schema.csv /mnt/data/epa/RCRA_flat_files/lu_horizontal_collection.txt | psql -c '\COPY lu_horizontal_collection FROM STDIN WITH CSV HEADER'
echo lu_horizontal_collection has been loaded into the database.

echo loading lu_horizontal_reference into the database ...
in2csv -e iso-8859-1 -f fixed -s lu_horizontal_reference_schema.csv /mnt/data/epa/RCRA_flat_files/lu_horizontal_reference.txt | psql -c '\COPY lu_horizontal_reference FROM STDIN WITH CSV HEADER'
echo lu_horizontal_reference has been loaded into the database.

echo loading lu_verification into the database ...
in2csv -e iso-8859-1 -f fixed -s lu_verification_schema.csv /mnt/data/epa/RCRA_flat_files/lu_verification.txt | psql -c '\COPY lu_verification FROM STDIN WITH CSV HEADER'
echo lu_verification has been loaded into the database.

