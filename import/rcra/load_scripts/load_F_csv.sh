#!/bin/bash -xv

RCRA_DIR=$1
echo loading fcost_estimate into the database ...
$RCRA_DIR/F/fcost_estimate.csv | psql -c '\COPY rcra.fcost_estimate FROM STDIN WITH CSV HEADER'
echo rcra.fcost_estimate has been loaded into the database.

echo loading fln_cost_mechanism_detail into the database ...
$RCRA_DIR/F/fln_cost_mechanism_detail.csv | psql -c '\COPY rcra.fln_cost_mechanism_detail FROM STDIN WITH CSV HEADER'
echo rcra.fln_cost_mechanism_detail has been loaded into the database.

echo loading fmechanism_detail into the database ...
$RCRA_DIR/F/fmechanism_detail.csv | psql -c '\COPY rcra.fmechanism_detail FROM STDIN WITH CSV HEADER'
echo rcra.fmechanism_detail has been loaded into the database.

echo loading fmechanism into the database ...
$RCRA_DIR/F/fmechanism.csv | psql -c '\COPY rcra.fmechanism FROM STDIN WITH CSV HEADER'
echo rcra.fmechanism has been loaded into the database.

