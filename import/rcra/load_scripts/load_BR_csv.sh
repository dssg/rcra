#!/bin/bash -xv

RCRA_DIR=$1
echo loading br_reporting into the database ...
$RCRA_DIR/BR/br_reporting.csv | psql -c '\COPY rcra.br_reporting FROM STDIN WITH CSV HEADER'
echo rcra.br_reporting has been loaded into the database.

echo loading bgm_waste_code into the database ...
$RCRA_DIR/BR/bgm_waste_code.csv | psql -c '\COPY rcra.bgm_waste_code FROM STDIN WITH CSV HEADER'
echo rcra.bgm_waste_code has been loaded into the database.

echo loading bwr_waste_code into the database ...
$RCRA_DIR/BR/bwr_waste_code.csv | psql -c '\COPY rcra.bwr_waste_code FROM STDIN WITH CSV HEADER'
echo rcra.bwr_waste_code has been loaded into the database.

