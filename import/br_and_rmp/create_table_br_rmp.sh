#!/bin/bash -xv

# NOTE: BR data received via email

psql -f drop_table_br_rmp.sql
psql -f create_table_br_rmp.sql

echo loading export_CAA112r_Insp2.csv from ECHO dashboard into the database ...
cat export_CAA112r_Insp2.csv | psql -h dssgsummer2014postgres.c5faqozfo86k.us-west-2.rds.amazonaws.com -U epa -d epa -c '\COPY "rmp_caa_inspection" FROM STDIN WITH CSV HEADER;'
echo export_CAA112r_Insp2.csv has been loaded into the database as rmp_caa_inspection.


echo loading br_reporting_complete.csv into the database ...
cat br_reporting_complete.csv | psql -h dssgsummer2014postgres.c5faqozfo86k.us-west-2.rds.amazonaws.com -U epa -d epa -c '\COPY "brs_all" FROM STDIN WITH CSV HEADER;'
echo br_reporting_complete.csv has been loaded into the database as brs_all.
