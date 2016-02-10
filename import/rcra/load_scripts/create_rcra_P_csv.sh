#!/bin/bash                                                                 

RCRA_DIR=$1
DICT_DIR=$2
OUTPUT_DIR=$3

in2csv -e iso-8859-1 -f fixed -s $DICT_DIR/pseries_schema.csv $RCRA_DIR/p1.txt > $OUTPUT_DIR/pseries.csv

in2csv -e iso-8859-1 -f fixed -s $DICT_DIR/pevent_schema.csv $RCRA_DIR/p2.txt > $OUTPUT_DIR/pevent.csv

in2csv -e iso-8859-1 -f fixed -s $DICT_DIR/punit_schema.csv $RCRA_DIR/p3.txt > $OUTPUT_DIR/punit.csv

in2csv -e iso-8859-1 -f fixed -s $DICT_DIR/punit_detail_schema.csv $RCRA_DIR/p4.txt > $OUTPUT_DIR/punit_detail.csv


in2csv -e iso-8859-1 -f fixed -s $DICT_DIR/pln_event_unit_detail_schema.csv $RCRA_DIR/p5.txt > $OUTPUT_DIR/pln_event_unit_detail.csv


in2csv -e iso-8859-1 -f fixed -s $DICT_DIR/plu_permit_event_code_schema.csv $RCRA_DIR/p6.txt > $OUTPUT_DIR/plu_permit_event_code.csv


in2csv -e iso-8859-1 -f fixed -s $DICT_DIR/plu_process_code_schema.csv $RCRA_DIR/p7.txt > $OUTPUT_DIR/plu_process_code.csv


in2csv -e iso-8859-1 -f fixed -s $DICT_DIR/plu_unit_of_measure_schema.csv $RCRA_DIR/p8.txt > $OUTPUT_DIR/plu_unit_of_measure.csv


in2csv -e iso-8859-1 -f fixed -s $DICT_DIR/pln_unit_detail_waste_schema.csv $RCRA_DIR/p9.txt > $OUTPUT_DIR/pln_unit_detail_waste.csv

in2csv -e iso-8859-1 -f fixed -s $DICT_DIR/plu_legal_operating_status_schema.csv $RCRA_DIR/lu_legal_operating_status.txt > $OUTPUT_DIR/plu_legal_operating_status.csv
