#!/bin/bash -xv

RCRA_DIR=$1

psql -f import/rcra/create_table_F.sql

echo loading fcost_estimate into the database ...
in2csv -e iso-8859-1 -f fixed -s $RCRA_DIR/fcost_estimate_schema.csv $RCRA_DIR/fcost_estimate.txt | psql -c '\COPY rcra.fcost_estimate FROM STDIN WITH CSV HEADER'
echo fcost_estimate has been loaded into the database.

echo loading fln_cost_mechanism_detail into the database ...
in2csv -e iso-8859-1 -f fixed -s $RCRA_DIR/fln_cost_mechanism_detail_schema.csv $RCRA_DIR/fln_cost_mechanism_detail.txt | psql -c '\COPY rcra.fln_cost_mechanism_detail FROM STDIN WITH CSV HEADER'
echo fln_cost_mechanism_detail has been loaded into the database.

echo loading fmechanism_detail into the database ...
in2csv -e iso-8859-1 -f fixed -s $RCRA_DIR/fmechanism_detail_schema.csv $RCRA_DIR/fmechanism_detail.txt | psql -c '\COPY rcra.fmechanism_detail FROM STDIN WITH CSV HEADER'
echo fmechanism_detail has been loaded into the database.

echo loading fmechanism into the database ...
in2csv -e iso-8859-1 -f fixed -s $RCRA_DIR/fmechanism_schema.csv $RCRA_DIR/fmechanism.txt | psql -c '\COPY rcra.fmechanism FROM STDIN WITH CSV HEADER'
echo fmechanism has been loaded into the database.

