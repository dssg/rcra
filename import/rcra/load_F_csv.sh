#!/bin/bash -xv

psql -f drop_table_F.sql
psql -f create_table_F.sql

echo loading fcost_estimate into the database ...
in2csv -e iso-8859-1 -f fixed -s fcost_estimate_schema.csv /mnt/data/epa/RCRA_flat_files/fcost_estimate.txt | psql -c '\COPY fcost_estimate FROM STDIN WITH CSV HEADER'
echo fcost_estimate has been loaded into the database.

echo loading fln_cost_mechanism_detail into the database ...
in2csv -e iso-8859-1 -f fixed -s fln_cost_mechanism_detail_schema.csv /mnt/data/epa/RCRA_flat_files/fln_cost_mechanism_detail.txt | psql -c '\COPY fln_cost_mechanism_detail FROM STDIN WITH CSV HEADER'
echo fln_cost_mechanism_detail has been loaded into the database.

echo loading fmechanism_detail into the database ...
in2csv -e iso-8859-1 -f fixed -s fmechanism_detail_schema.csv /mnt/data/epa/RCRA_flat_files/fmechanism_detail.txt | psql -c '\COPY fmechanism_detail FROM STDIN WITH CSV HEADER'
echo fmechanism_detail has been loaded into the database.

echo loading fmechanism into the database ...
in2csv -e iso-8859-1 -f fixed -s fmechanism_schema.csv /mnt/data/epa/RCRA_flat_files/fmechanism.txt | psql -c '\COPY fmechanism FROM STDIN WITH CSV HEADER'
echo fmechanism has been loaded into the database.

