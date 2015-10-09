#!/bin/bash -xv

psql -f drop_table_C.sql
psql -f create_table_C.sql

echo loading cmecomp3 into the database ...
in2csv -e iso-8859-1 -f fixed -s cmecomp3_schema.csv /mnt/data/epa/RCRA_flat_files/cmecomp3.txt | psql -c '\COPY cmecomp3 FROM STDIN WITH CSV HEADER'
echo cmecomp3 has been loaded into the database.

echo loading ccitation into the database ...
in2csv -e iso-8859-1 -f fixed -s ccitation_schema.csv /mnt/data/epa/RCRA_flat_files/ccitation.txt | psql -c '\COPY ccitation FROM STDIN WITH CSV HEADER'
echo ccitation has been loaded into the database.

echo loading lu_citation into the database ...
in2csv -e iso-8859-1 -f fixed -s lu_citation_schema.csv /mnt/data/epa/RCRA_flat_files/lu_citation.txt | psql -c '\COPY lu_citation FROM STDIN WITH CSV HEADER'
echo lu_citation has been loaded into the database.

