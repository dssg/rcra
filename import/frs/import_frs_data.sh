#!/bin/bash 

FRS_DIR=$1

psql -v ON_ERROR_STOP=1 -f import/frs/create_table_frs.sql

cat $FRS_DIR/FRS_FACILITIES.csv | psql -v ON_ERROR_STOP=1 -c '\COPY frs.facilities FROM STDIN WITH CSV HEADER;' || exit 1
cat $FRS_DIR/FRS_PROGRAM_LINKS.csv | psql -v ON_ERROR_STOP=1 -c '\COPY frs.program_links FROM STDIN WITH CSV HEADER;'

