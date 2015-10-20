#!/bin/bash -xv                                                                 

RCRA_DIR=$1
DICT_DIR=$2
OUTPUT_DIR=$3

in2csv -e iso-8859-1 -f fixed -s $DICT_DIR/gis_schema.csv $RCRA_DIR/gis.txt > $OUTPUT_DIR/gis.csv

in2csv -e iso-8859-1 -f fixed -s $DICT_DIR/gis_lat_long_schema.csv $RCRA_DIR/gis_lat_long.txt > $OUTPUT_DIR/gis_lat_long.csv

in2csv -e iso-8859-1 -f fixed -s $DICT_DIR/lu_area_source_schema.csv $RCRA_DIR/lu_area_source.txt > $OUTPUT_DIR/lu_area_source.csv

in2csv -e iso-8859-1 -f fixed -s $DICT_DIR/lu_coordinate_schema.csv $RCRA_DIR/lu_coordinate.txt > $OUTPUT_DIR/lu_coordinate.csv 

in2csv -e iso-8859-1 -f fixed -s $DICT_DIR/lu_geographic_reference_schema.csv $RCRA_DIR/lu_geographic_reference.txt > $OUTPUT_DIR/lu_geographic_reference.csv

in2csv -e iso-8859-1 -f fixed -s $DICT_DIR/lu_geometric_schema.csv $RCRA_DIR/lu_geometric.txt > $OUTPUT_DIR/lu_geometric.csv

in2csv -e iso-8859-1 -f fixed -s $DICT_DIR/lu_horizontal_collection_schema.csv $RCRA_DIR/lu_horizontal_collection.txt > $OUTPUT_DIR/lu_horizontal_collection.csv

in2csv -e iso-8859-1 -f fixed -s $DICT_DIR/lu_horizontal_reference_schema.csv $RCRA_DIR/lu_horizontal_reference.txt > $OUTPUT_DIR/lu_horizontal_reference.csv

in2csv -e iso-8859-1 -f fixed -s $DICT_DIR/lu_verification_schema.csv $RCRA_DIR/lu_verification.txt > $OUTPUT_DIR/lu_verification.csv
