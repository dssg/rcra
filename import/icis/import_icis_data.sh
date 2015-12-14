#!/bin/bash -xv

ICIS_DIR=$1

NPDES_DIR=$ICIS_DIR/npdes_downloads/
FEC_DIR=$ICIS_DIR/case_downloads/
AIR_DIR=$ICIS_DIR/ICIS-AIR_downloads/

for name in $FEC_DIR/CASE*
do
    name=$(basename "$name")
    newname=FEC"$(echo "$name" | cut -c5-)"
    mv $FEC_DIR/"$name" $FEC_DIR/"$newname"
done

for name in $AIR_DIR/ICIS*
do
    name=$(basename "$name")
    newname="$(echo "$name" | cut -c6-)"
    mv $AIR_DIR/"$name" $AIR_DIR/"$newname"
done


for directory in $NPDES_DIR $FEC_DIR $AIR_DIR
do
    for filename in $directory/*
    do
	file_csv=$(basename "$filename")
	table_name=${file_csv%.*}
	tr -d '(\r|\000)' < $directory'/'$file_csv | psql -v ON_ERROR_STOP=1 -c '\'"COPY icis.${table_name,,} FROM STDIN WITH CSV HEADER;"
    done

done
