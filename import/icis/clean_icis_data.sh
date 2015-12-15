#!/bin/bash -xv

ICIS_DIR=$1

FEC_DIR=$ICIS_DIR/case_downloads
AIR_DIR=$ICIS_DIR/ICIS-AIR_downloads

for name in "$FEC_DIR"/CASE*
do
    if [ -e "$name" ]
	then
	    name=$(basename "$name")
	    newname=FEC"$(echo "$name" | cut -c5-)"
	    mv $FEC_DIR/"$name" $FEC_DIR/"$newname"
    fi
done

for name in "$AIR_DIR"/ICIS*
do
    if [ -e "$name" ]
	then
            name=$(basename "$name")
            newname="$(echo "$name" | cut -c6-)"
            mv $AIR_DIR/"$name" $AIR_DIR/"$newname"
    fi
done












