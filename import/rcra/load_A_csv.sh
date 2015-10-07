#!/bin/bash -xv

psql -f drop_table_A.sql
psql -f create_table_A.sql

echo loading aarea into the database ...
in2csv -e iso-8859-1 -f fixed -s aarea_schema.csv /mnt/data/epa/RCRA_flat_files/aarea.txt | psql -c '\COPY aarea FROM STDIN WITH CSV HEADER'
echo aarea has been loaded into the database.

echo loading aevent into the database ...
in2csv -e iso-8859-1 -f fixed -s aevent_schema.csv /mnt/data/epa/RCRA_flat_files/aevent.txt | psql -c '\COPY aevent FROM STDIN WITH CSV HEADER'
echo aevent has been loaded into the database.

echo loading aauthority into the database ...
in2csv -e iso-8859-1 -f fixed -s aauthority_schema.csv /mnt/data/epa/RCRA_flat_files/aauthority.txt | psql -c '\COPY aauthority FROM STDIN WITH CSV HEADER'
echo aauthority has been loaded into the database.

echo loading aln_area_event into the database ...
in2csv -e iso-8859-1 -f fixed -s aln_area_event_schema.csv /mnt/data/epa/RCRA_flat_files/aln_area_event.txt | psql -c '\COPY aln_area_event FROM STDIN WITH CSV HEADER'
echo aln_area_event has been loaded into the database.

echo loading aln_event_authority into the database ...
in2csv -e iso-8859-1 -f fixed -s aln_event_authority_schema.csv /mnt/data/epa/RCRA_flat_files/aln_event_authority.txt | psql -c '\COPY aln_event_authority FROM STDIN WITH CSV HEADER'
echo aln_event_authority has been loaded into the database.

echo loading alu_ca_event into the database ...
in2csv -e iso-8859-1 -f fixed -s alu_ca_event_schema.csv /mnt/data/epa/RCRA_flat_files/alu_ca_event.txt | psql -c '\COPY alu_ca_event FROM STDIN WITH CSV HEADER'
echo alu_ca_event has been loaded into the database.

echo loading alu_authority into the database ...
in2csv -e iso-8859-1 -f fixed -s alu_authority_schema.csv /mnt/data/epa/RCRA_flat_files/alu_authority.txt | psql -c '\COPY alu_authority FROM STDIN WITH CSV HEADER'
echo alu_authority has been loaded into the database.

echo loading aln_authority_citation into the database ...
in2csv -e iso-8859-1 -f fixed -s aln_authority_citation_schema.csv /mnt/data/epa/RCRA_flat_files/aln_authority_citation.txt | psql -c '\COPY aln_authority_citation FROM STDIN WITH CSV HEADER'
echo aln_authority_citation has been loaded into the database.

echo loading alu_statutory_citation into the database ...
in2csv -e iso-8859-1 -f fixed -s alu_statutory_citation_schema.csv /mnt/data/epa/RCRA_flat_files/alu_statutory_citation.txt | psql -c '\COPY alu_statutory_citation FROM STDIN WITH CSV HEADER'
echo alu_statutory_citation has been loaded into the database.

echo loading aln_area_unit into the database ...
in2csv -e iso-8859-1 -f fixed -s aln_area_unit_schema.csv /mnt/data/epa/RCRA_flat_files/aln_area_unit.txt | psql -c '\COPY aln_area_unit FROM STDIN WITH CSV HEADER'
echo aln_area_unit has been loaded into the database.

