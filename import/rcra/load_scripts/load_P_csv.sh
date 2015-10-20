#!/bin/bash -xv

RCRA_DIR=$1
echo loading pseries into the database ...
$RCRA_DIR/P/pseries.csv | psql -c '\COPY rcra.pseries FROM STDIN WITH CSV HEADER'
echo rcra.pseries has been loaded into the database.

echo loading pevent into the database ...
$RCRA_DIR/P/pevent.csv | psql -c '\COPY rcra.pevent FROM STDIN WITH CSV HEADER'
echo rcra.pevent has been loaded into the database.

echo loading punit into the database ...
$RCRA_DIR/P/punit.csv | psql -c '\COPY rcra.punit FROM STDIN WITH CSV HEADER'
echo rcra.punit has been loaded into the database.

echo loading punit_detail into the database ...
$RCRA_DIR/P/punit_detail.csv | psql -c '\COPY rcra.punit_detail FROM STDIN WITH CSV HEADER'
echo rcra.punit_detail has been loaded into the database.

echo loading pln_event_unit_detail into the database ...
$RCRA_DIR/P/pln_event_unit_detail.csv | psql -c '\COPY rcra.pln_event_unit_detail FROM STDIN WITH CSV HEADER'
echo rcra.pln_event_unit_detail has been loaded into the database.

echo loading plu_permit_event_code into the database ...
$RCRA_DIR/P/plu_permit_event_code.csv | psql -c '\COPY rcra.plu_permit_event_code FROM STDIN WITH CSV HEADER'
echo rcra.plu_permit_event_code has been loaded into the database.

echo loading plu_process_code into the database ...
$RCRA_DIR/P/plu_process_code.csv | psql -c '\COPY rcra.plu_process_code FROM STDIN WITH CSV HEADER'
echo rcra.plu_process_code has been loaded into the database.

echo loading plu_unit_of_measure into the database ...
$RCRA_DIR/P/plu_unit_of_measure.csv | psql -c '\COPY rcra.plu_unit_of_measure FROM STDIN WITH CSV HEADER'
echo rcra.plu_unit_of_measure has been loaded into the database.

echo loading pln_unit_detail_waste into the database ...
$RCRA_DIR/P/pln_unit_detail_waste.csv | psql -c '\COPY rcra.pln_unit_detail_waste FROM STDIN WITH CSV HEADER'
echo rcra.pln_unit_detail_waste has been loaded into the database.

echo loading plu_legal_operating_status into the database ...
$RCRA_DIR/P/plu_legal_operating_status.csv | psql -c '\COPY rcra.plu_legal_operating_status FROM STDIN WITH CSV HEADER'
echo rcra.plu_legal_operating_status has been loaded into the database.

