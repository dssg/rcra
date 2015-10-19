#!/bin/bash -xv
# NOTE: BR data received via email

BR_RMP_DIR=$1

psql -f import/br_and_rmp/drop_table_br_rmp.sql
psql -f import/br_and_rmp/create_table_br_rmp.sql

echo loading export_CAA112r_Insp2.csv from ECHO dashboard into the database ...
cat $BR_RMP_DIR/export_CAA112r_Insp2.csv | psql -c '\COPY br_and_rmp.caa_inspections FROM STDIN WITH CSV HEADER;'
echo export_CA112r_Insp2.csv has been loaded into the database as br_and_rmp.caa_inspections.


echo loading br_reporting_complete.csv into the database ...
cat $BR_RMP_DIR/br_reporting_complete.csv | psql -c '\COPY br_and_rmp.brs_all FROM STDIN WITH CSV HEADER;'
echo br_reporting_complete.csv has been loaded into the database as brs_all.
