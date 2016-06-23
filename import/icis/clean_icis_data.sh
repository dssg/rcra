#!/bin/bash

FEC_DIR=$1
AIR_DIR=$2

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












