#!/bin/bash -xv                                                                 

RCRA_DIR=$1
DICT_DIR=$2
OUTPUT_DIR=$3

in2csv -e iso-8859-1 -f fixed -s $DICT_DIR/br_reporting_schema.csv $RCRA_DIR/br_reporting.txt > $OUTPUT_DIR/br_reporting.csv

in2csv -e iso-8859-1 -f fixed -s $DICT_DIR/bgm_waste_code_schema.csv $RCRA_DIR/bgm_waste_code.txt > $OUTPUT_DIR/bgm_waste_code.csv

in2csv -e iso-8859-1 -f fixed -s $DICT_DIR/bwr_waste_code_schema.csv $RCRA_DIR/bwr_waste_code.txt > $OUTPUT_DIR/bwr_waste_code.csv
