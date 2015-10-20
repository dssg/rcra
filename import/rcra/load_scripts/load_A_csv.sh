#!/bin/bash -xv

RCRA_DIR=$1
echo loading aarea into the database ...
$RCRA_DIR/A/aarea.csv | psql -c '\COPY rcra.aarea FROM STDIN WITH CSV HEADER'
echo rcra.aarea has been loaded into the database.

echo loading aevent into the database ...
$RCRA_DIR/A/aevent.csv | psql -c '\COPY rcra.aevent FROM STDIN WITH CSV HEADER'
echo rcra.aevent has been loaded into the database.

echo loading aauthority into the database ...
$RCRA_DIR/A/aauthority.csv | psql -c '\COPY rcra.aauthority FROM STDIN WITH CSV HEADER'
echo rcra.aauthority has been loaded into the database.

echo loading aln_area_event into the database ...
$RCRA_DIR/A/aln_area_event.csv | psql -c '\COPY rcra.aln_area_event FROM STDIN WITH CSV HEADER'
echo rcra.aln_area_event has been loaded into the database.

echo loading aln_event_authority into the database ...
$RCRA_DIR/A/aln_event_authority.csv | psql -c '\COPY rcra.aln_event_authority FROM STDIN WITH CSV HEADER'
echo rcra.aln_event_authority has been loaded into the database.

echo loading alu_ca_event into the database ...
$RCRA_DIR/A/alu_ca_event.csv | psql -c '\COPY rcra.alu_ca_event FROM STDIN WITH CSV HEADER'
echo rcra.alu_ca_event has been loaded into the database.

echo loading alu_authority into the database ...
$RCRA_DIR/A/alu_authority.csv | psql -c '\COPY rcra.alu_authority FROM STDIN WITH CSV HEADER'
echo rcra.alu_authority has been loaded into the database.

echo loading aln_authority_citation into the database ...
$RCRA_DIR/A/aln_authority_citation.csv | psql -c '\COPY rcra.aln_authority_citation FROM STDIN WITH CSV HEADER'
echo rcra.aln_authority_citation has been loaded into the database.

echo loading alu_statutory_citation into the database ...
$RCRA_DIR/A/alu_statutory_citation.csv | psql -c '\COPY rcra.alu_statutory_citation FROM STDIN WITH CSV HEADER'
echo rcra.alu_statutory_citation has been loaded into the database.

echo loading aln_area_unit into the database ...
$RCRA_DIR/A/aln_area_unit.csv | psql -c '\COPY rcra.aln_area_unit FROM STDIN WITH CSV HEADER'
echo rcra.aln_area_unit has been loaded into the database.

