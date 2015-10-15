#!/bin/bash -xv

RCRA_DIR=$1
DICT_DIR=$2
OUTPUT_DIR=$3

in2csv -e iso-8859-1 -f fixed -s $DICT_DIR/aarea_schema.csv $RCRA_DIR/a1.txt > $OUTPUT_DIR/aarea.csv

in2csv -e iso-8859-1 -f fixed -s $DICT_DIR/aevent_schema.csv $RCRA_DIR/a2.txt > $OUTPUT_DIR/aevent.csv

in2csv -e iso-8859-1 -f fixed -s $DICT_DIR/aauthority_schema.csv $RCRA_DIR/a3.txt > $OUTPUT_DIR/aauthority.csv

in2csv -e iso-8859-1 -f fixed -s $DICT_DIR/aln_area_event_schema.csv $RCRA_DIR/a4.txt > $OUTPUT_DIR/aln_area_event.csv

in2csv -e iso-8859-1 -f fixed -s $DICT_DIR/aln_event_authority_schema.csv $RCRA_DIR/a5.txt > $OUTPUT_DIR/aln_event_authority.csv

in2csv -e iso-8859-1 -f fixed -s $DICT_DIR/alu_ca_event_schema.csv $RCRA_DIR/a6.txt > $OUTPUT_DIR/alu_ca_event.csv

in2csv -e iso-8859-1 -f fixed -s $DICT_DIR/alu_authority_schema.csv $RCRA_DIR/a7.txt > $OUTPUT_DIR/alu_authority.csv

in2csv -e iso-8859-1 -f fixed -s $DICT_DIR/aln_authority_citation_schema.csv $RCRA_DIR/a8.txt > $OUTPUT_DIR/aln_authority_citation.csv

in2csv -e iso-8859-1 -f fixed -s $DICT_DIR/alu_statutory_citation_schema.csv $RCRA_DIR/a9.txt > $OUTPUT_DIR/alu_statutory_citation.csv

in2csv -e iso-8859-1 -f fixed -s $DICT_DIR/aln_area_unit_schema.csv $RCRA_DIR/a10.txt > $OUTPUT_DIR/aln_area_unit.csv
