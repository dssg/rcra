#!/bin/bash -xv

psql -f drop_table_P.sql
psql -f create_table_P.sql

echo loading pseries into the database ...
in2csv -e iso-8859-1 -f fixed -s pseries_schema.csv /mnt/data/epa/RCRA_flat_files/pseries.txt | psql -c '\COPY pseries FROM STDIN WITH CSV HEADER'
echo pseries has been loaded into the database.

echo loading pevent into the database ...
in2csv -e iso-8859-1 -f fixed -s pevent_schema.csv /mnt/data/epa/RCRA_flat_files/pevent.txt | psql -c '\COPY pevent FROM STDIN WITH CSV HEADER'
echo pevent has been loaded into the database.

echo loading punit into the database ...
in2csv -e iso-8859-1 -f fixed -s punit_schema.csv /mnt/data/epa/RCRA_flat_files/punit.txt | psql -c '\COPY punit FROM STDIN WITH CSV HEADER'
echo punit has been loaded into the database.

echo loading punit_detail into the database ...
in2csv -e iso-8859-1 -f fixed -s punit_detail_schema.csv /mnt/data/epa/RCRA_flat_files/punit_detail.txt | psql -c '\COPY punit_detail FROM STDIN WITH CSV HEADER'
echo punit_detail has been loaded into the database.

echo loading pln_event_unit_detail into the database ...
in2csv -e iso-8859-1 -f fixed -s pln_event_unit_detail_schema.csv /mnt/data/epa/RCRA_flat_files/pln_event_unit_detail.txt | psql -c '\COPY pln_event_unit_detail FROM STDIN WITH CSV HEADER'
echo pln_event_unit_detail has been loaded into the database.

echo loading plu_permit_event_code into the database ...
in2csv -e iso-8859-1 -f fixed -s plu_permit_event_code_schema.csv /mnt/data/epa/RCRA_flat_files/plu_permit_event_code.txt | psql -c '\COPY plu_permit_event_code FROM STDIN WITH CSV HEADER'
echo plu_permit_event_code has been loaded into the database.

echo loading plu_process_code into the database ...
in2csv -e iso-8859-1 -f fixed -s plu_process_code_schema.csv /mnt/data/epa/RCRA_flat_files/plu_process_code.txt | psql -c '\COPY plu_process_code FROM STDIN WITH CSV HEADER'
echo plu_process_code has been loaded into the database.

echo loading plu_unit_of_measure into the database ...
in2csv -e iso-8859-1 -f fixed -s plu_unit_of_measure_schema.csv /mnt/data/epa/RCRA_flat_files/plu_unit_of_measure.txt | psql -c '\COPY plu_unit_of_measure FROM STDIN WITH CSV HEADER'
echo plu_unit_of_measure has been loaded into the database.

echo loading pln_unit_detail_waste into the database ...
in2csv -e iso-8859-1 -f fixed -s pln_unit_detail_waste_schema.csv /mnt/data/epa/RCRA_flat_files/pln_unit_detail_waste.txt | psql -c '\COPY pln_unit_detail_waste FROM STDIN WITH CSV HEADER'
echo pln_unit_detail_waste has been loaded into the database.

echo loading plu_legal_operating_status into the database ...
in2csv -e iso-8859-1 -f fixed -s plu_legal_operating_status_schema.csv /mnt/data/epa/RCRA_flat_files/plu_legal_operating_status.txt | psql -c '\COPY plu_legal_operating_status FROM STDIN WITH CSV HEADER'
echo plu_legal_operating_status has been loaded into the database.

