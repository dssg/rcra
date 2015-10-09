#!/bin/bash -xv

psql -f drop_table_BR.sql
psql -f create_table_BR.sql

echo loading br_reporting into the database ...
in2csv -e iso-8859-1 -f fixed -s br_reporting_schema.csv /mnt/data/epa/RCRA_flat_files/br_reporting.txt | psql -c '\COPY br_reporting FROM STDIN WITH CSV HEADER'
echo br_reporting has been loaded into the database.

echo loading bgm_waste_code into the database ...
in2csv -e iso-8859-1 -f fixed -s bgm_waste_code_schema.csv /mnt/data/epa/RCRA_flat_files/bgm_waste_code.txt | psql -c '\COPY bgm_waste_code FROM STDIN WITH CSV HEADER'
echo bgm_waste_code has been loaded into the database.

echo loading bwr_waste_code into the database ...
in2csv -e iso-8859-1 -f fixed -s bwr_waste_code_schema.csv /mnt/data/epa/RCRA_flat_files/bwr_waste_code.txt | psql -c '\COPY bwr_waste_code FROM STDIN WITH CSV HEADER'
echo bwr_waste_code has been loaded into the database.

