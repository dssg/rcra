#!/bin/bash -xv

RCRA_DIR=$1

psql -f import/rcra/create_table_BR.sql

echo loading br_reporting into the database ...
in2csv -e iso-8859-1 -f fixed -s $RCRA_DIR/br_reporting_schema.csv $RCRA_DIR/br_reporting.txt | psql -c '\COPY rcra.br_reporting FROM STDIN WITH CSV HEADER'
echo br_reporting has been loaded into the database.

echo loading bgm_waste_code into the database ...
in2csv -e iso-8859-1 -f fixed -s $RCRA_DIR/bgm_waste_code_schema.csv $RCRA_DIR/bgm_waste_code.txt | psql -c '\COPY rcra.bgm_waste_code FROM STDIN WITH CSV HEADER'
echo bgm_waste_code has been loaded into the database.

echo loading bwr_waste_code into the database ...
in2csv -e iso-8859-1 -f fixed -s $RCRA_DIR/bwr_waste_code_schema.csv $RCRA_DIR/bwr_waste_code.txt | psql -c '\COPY rcra.bwr_waste_code FROM STDIN WITH CSV HEADER'
echo bwr_waste_code has been loaded into the database.

