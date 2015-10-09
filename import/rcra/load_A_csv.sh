#!/bin/bash -xv

RCRA_DIR=$1

psql -f import/rcra/create_table_A.sql

echo loading aarea into the database ...
in2csv -e iso-8859-1 -f fixed -s $RCRA_DIR/aarea_schema.csv $RCRA_DIR/aarea.txt | psql -c '\COPY rcra.aarea FROM STDIN WITH CSV HEADER'
echo aarea has been loaded into the database.

echo loading aevent into the database ...
in2csv -e iso-8859-1 -f fixed -s $RCRA_DIR/aevent_schema.csv $RCRA_DIR/aevent.txt | psql -c '\COPY rcra.aevent FROM STDIN WITH CSV HEADER'
echo aevent has been loaded into the database.

echo loading aauthority into the database ...
in2csv -e iso-8859-1 -f fixed -s $RCRA_DIR/aauthority_schema.csv $RCRA_DIR/aauthority.txt | psql -c '\COPY rcra.aauthority FROM STDIN WITH CSV HEADER'
echo aauthority has been loaded into the database.

echo loading aln_area_event into the database ...
in2csv -e iso-8859-1 -f fixed -s $RCRA_DIR/aln_area_event_schema.csv $RCRA_DIR/aln_area_event.txt | psql -c '\COPY rcra.aln_area_event FROM STDIN WITH CSV HEADER'
echo aln_area_event has been loaded into the database.

echo loading aln_event_authority into the database ...
in2csv -e iso-8859-1 -f fixed -s $RCRA_DIR/aln_event_authority_schema.csv $RCRA_DIR/aln_event_authority.txt | psql -c '\COPY rcra.aln_event_authority FROM STDIN WITH CSV HEADER'
echo aln_event_authority has been loaded into the database.

echo loading alu_ca_event into the database ...
in2csv -e iso-8859-1 -f fixed -s $RCRA_DIR/alu_ca_event_schema.csv $RCRA_DIR/alu_ca_event.txt | psql -c '\COPY rcra.alu_ca_event FROM STDIN WITH CSV HEADER'
echo alu_ca_event has been loaded into the database.

echo loading alu_authority into the database ...
in2csv -e iso-8859-1 -f fixed -s $RCRA_DIR/alu_authority_schema.csv $RCRA_DIR/alu_authority.txt | psql -c '\COPY rcra.alu_authority FROM STDIN WITH CSV HEADER'
echo alu_authority has been loaded into the database.

echo loading aln_authority_citation into the database ...
in2csv -e iso-8859-1 -f fixed -s $RCRA_DIR/aln_authority_citation_schema.csv $RCRA_DIR/aln_authority_citation.txt | psql -c '\COPY rcra.aln_authority_citation FROM STDIN WITH CSV HEADER'
echo aln_authority_citation has been loaded into the database.

echo loading alu_statutory_citation into the database ...
in2csv -e iso-8859-1 -f fixed -s $RCRA_DIR/alu_statutory_citation_schema.csv $RCRA_DIR/alu_statutory_citation.txt | psql -c '\COPY rcra.alu_statutory_citation FROM STDIN WITH CSV HEADER'
echo alu_statutory_citation has been loaded into the database.

echo loading aln_area_unit into the database ...
in2csv -e iso-8859-1 -f fixed -s $RCRA_DIR/aln_area_unit_schema.csv $RCRA_DIR/aln_area_unit.txt | psql -c '\COPY rcra.aln_area_unit FROM STDIN WITH CSV HEADER'
echo aln_area_unit has been loaded into the database.

