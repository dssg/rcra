#!/bin/bash -xv

TRI_DIR=$1
i=$2
OUTPUT=$3

head -1 $TRI_DIR/US_${i}_1987_v13.txt > $TRI_DIR/tri_${i}.txt; tail -q -n +2 $TRI_DIR/US_${i}_*_v13.txt >> $TRI_DIR/tri_${i}.txt

in2csv -t -f csv -e iso-8859-1 $TRI_DIR/tri_${i}.txt
