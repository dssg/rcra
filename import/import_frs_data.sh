#!/bin/bash -xv

FRS_DIR=$1

psql -f import/create_table_frs.sql

echo loading frs_facilities.csv into the database ...
cat $FRS/frs_facilities.csv | psql -c '\COPY import.frs_facilities FROM STDIN WITH CSV HEADER;'
echo frs_facilities has been loaded into the database.


echo loading frs_program_links.csv into the database ...
cat $FRS/frs_program_links.csv | psql -c '\COPY import.frs_program_links FROM STDIN WITH CSV HEADER;'
echo frs_program_links has been loaded into the database.
