#!/bin/bash

RCRA_DIR=$1
DICT_DIR=$2
OUTPUT_DIR=$3

in2csv -e iso-8859-1 -f fixed -s $DICT_DIR/cmecomp3_schema.csv $RCRA_DIR/cmecomp3.txt > $OUTPUT_DIR/cmecomp3.csv

# Removing bad line from cmecomp. One time fix only
sed -i '/^,/d' $OUTPUT_DIR/cmecomp3.csv

in2csv -e iso-8859-1 -f fixed -s $DICT_DIR/ccitation_schema.csv $RCRA_DIR/ccitation.txt > $OUTPUT_DIR/ccitation.csv

in2csv -e iso-8859-1 -f fixed -s $DICT_DIR/lu_citation_schema.csv $RCRA_DIR/lu_citation.txt > $OUTPUT_DIR/lu_citation.csv
