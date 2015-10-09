#!/bin/bash -xv

RCRA_DIR=$1

psql -f import/rcra/create_table_C.sql

echo loading cmecomp3 into the database ...
in2csv -e iso-8859-1 -f fixed -s $RCRA_DIR/cmecomp3_schema.csv $RCRA_DIR/cmecomp3.txt | psql -c '\COPY rcra.cmecomp3 FROM STDIN WITH CSV HEADER'
echo cmecomp3 has been loaded into the database.

echo loading ccitation into the database ...
in2csv -e iso-8859-1 -f fixed -s $RCRA_DIR/ccitation_schema.csv $RCRA_DIR/ccitation.txt | psql -c '\COPY rcra.ccitation FROM STDIN WITH CSV HEADER'
echo ccitation has been loaded into the database.

echo loading lu_citation into the database ...
in2csv -e iso-8859-1 -f fixed -s $RCRA_DIR/lu_citation_schema.csv $RCRA_DIR/lu_citation.txt | psql -c '\COPY rcra.lu_citation FROM STDIN WITH CSV HEADER'
echo lu_citation has been loaded into the database.

