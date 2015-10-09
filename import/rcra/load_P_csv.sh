#!/bin/bash -xv

RCRA_DIR=$1

psql -f import/rcra/create_table_P.sql

echo loading pseries into the database ...
in2csv -e iso-8859-1 -f fixed -s $RCRA_DIR/pseries_schema.csv $RCRA_DIR/pseries.txt | psql -c '\COPY rcra.pseries FROM STDIN WITH CSV HEADER'
echo pseries has been loaded into the database.

echo loading pevent into the database ...
in2csv -e iso-8859-1 -f fixed -s $RCRA_DIR/pevent_schema.csv $RCRA_DIR/pevent.txt | psql -c '\COPY rcra.pevent FROM STDIN WITH CSV HEADER'
echo pevent has been loaded into the database.

echo loading punit into the database ...
in2csv -e iso-8859-1 -f fixed -s $RCRA_DIR/punit_schema.csv $RCRA_DIR/punit.txt | psql -c '\COPY rcra.punit FROM STDIN WITH CSV HEADER'
echo punit has been loaded into the database.

echo loading punit_detail into the database ...
in2csv -e iso-8859-1 -f fixed -s $RCRA_DIR/punit_detail_schema.csv $RCRA_DIR/punit_detail.txt | psql -c '\COPY rcra.punit_detail FROM STDIN WITH CSV HEADER'
echo punit_detail has been loaded into the database.

echo loading pln_event_unit_detail into the database ...
in2csv -e iso-8859-1 -f fixed -s $RCRA_DIR/pln_event_unit_detail_schema.csv $RCRA_DIR/pln_event_unit_detail.txt | psql -c '\COPY rcra.pln_event_unit_detail FROM STDIN WITH CSV HEADER'
echo pln_event_unit_detail has been loaded into the database.

echo loading plu_permit_event_code into the database ...
in2csv -e iso-8859-1 -f fixed -s $RCRA_DIR/plu_permit_event_code_schema.csv $RCRA_DIR/plu_permit_event_code.txt | psql -c '\COPY rcra.plu_permit_event_code FROM STDIN WITH CSV HEADER'
echo plu_permit_event_code has been loaded into the database.

echo loading plu_process_code into the database ...
in2csv -e iso-8859-1 -f fixed -s $RCRA_DIR/plu_process_code_schema.csv $RCRA_DIR/plu_process_code.txt | psql -c '\COPY rcra.plu_process_code FROM STDIN WITH CSV HEADER'
echo plu_process_code has been loaded into the database.

echo loading plu_unit_of_measure into the database ...
in2csv -e iso-8859-1 -f fixed -s $RCRA_DIR/plu_unit_of_measure_schema.csv $RCRA_DIR/plu_unit_of_measure.txt | psql -c '\COPY rcra.plu_unit_of_measure FROM STDIN WITH CSV HEADER'
echo plu_unit_of_measure has been loaded into the database.

echo loading pln_unit_detail_waste into the database ...
in2csv -e iso-8859-1 -f fixed -s $RCRA_DIR/pln_unit_detail_waste_schema.csv $RCRA_DIR/pln_unit_detail_waste.txt | psql -c '\COPY rcra.pln_unit_detail_waste FROM STDIN WITH CSV HEADER'
echo pln_unit_detail_waste has been loaded into the database.

echo loading plu_legal_operating_status into the database ...
in2csv -e iso-8859-1 -f fixed -s $RCRA_DIR/plu_legal_operating_status_schema.csv $RCRA_DIR/plu_legal_operating_status.txt | psql -c '\COPY rcra.plu_legal_operating_status FROM STDIN WITH CSV HEADER'
echo plu_legal_operating_status has been loaded into the database.

