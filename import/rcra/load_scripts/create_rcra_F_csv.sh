#!/bin/bash                                                               

RCRA_DIR=$1
DICT_DIR=$2
OUTPUT_DIR=$3

in2csv -e iso-8859-1 -f fixed -s $DICT_DIR/fcost_estimate_schema.csv $RCRA_DIR/fcost_estimate.txt > $OUTPUT_DIR/fcost_estimate.csv

in2csv -e iso-8859-1 -f fixed -s $DICT_DIR/fln_cost_mechanism_detail_schema.csv $RCRA_DIR/fln_cost_mechanism_detail.txt > $OUTPUT_DIR/fln_cost_mechanism_detail.csv

in2csv -e iso-8859-1 -f fixed -s $DICT_DIR/fmechanism_detail_schema.csv $RCRA_DIR/fmechanism_detail.txt > $OUTPUT_DIR/fmechanism_detail.csv

in2csv -e iso-8859-1 -f fixed -s $DICT_DIR/fmechanism_schema.csv $RCRA_DIR/fmechanism.txt > $OUTPUT_DIR/fmechanism.csv
