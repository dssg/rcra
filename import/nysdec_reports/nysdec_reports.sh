#!/bin/bash

# set path to NYSDEC reports data here
DPATH=$1
OUTPUT_DPATH=$2

# unzip the files
for year in 2006 2007 2008 2009 2010 2011 2012 2013 2014 2015
do
    unzip -o $DPATH/$year.zip -d $DPATH/$year
done

# reset permissions manually since unzip is weird
chmod -R 755 $DPATH/*

####################
# MANUAL FIXES
####################

# remove stray pipe from 2012 SI1 file
echo 'Removing stray pipe character'
sed -i 's/|//' $DPATH/2012/NYSI1208.fil

# remove carriage returns from the 2012 GM1 file
sed -i 's///' $DPATH/2012/NYGM1208.fil

# remove stray comment line from 2012 GM1 file
sed -i '7641,7642d' $DPATH/2012/NYGM1208.fil 

# convert fixed-width to CSV
for year in 2006 2007 2008 2009 2010 2011 2012 2013 2014 2015
do
    mkdir -p $OUTPUT_DPATH/$year

    # GM1 files
    gawk '$1=$1' FIELDWIDTHS='12 5 4 1 6 1 4 1 3 18 1 240 240 1 1' OFS='|' $DPATH/$year/NYGM1208.fil > $OUTPUT_DPATH/$year/NYGM1208.csv

    # GM2 files
    gawk '$1=$1' FIELDWIDTHS='12 5 4' OFS='|' $DPATH/$year/NYGM2208.fil > $OUTPUT_DPATH/$year/NYGM2208.csv

    # GM3 files
    gawk '$1=$1' FIELDWIDTHS='12 5 6' OFS='|' $DPATH/$year/NYGM3208.fil > $OUTPUT_DPATH/$year/NYGM3208.csv

    # GM4 files
    gawk '$1=$1' FIELDWIDTHS='12 5 5 4 12 18' OFS='|' $DPATH/$year/NYGM4208.fil > $OUTPUT_DPATH/$year/NYGM4208.csv

    # GM5 files
    gawk '$1=$1' FIELDWIDTHS='12 5 5 4 18' OFS='|' $DPATH/$year/NYGM5208.fil > $OUTPUT_DPATH/$year/NYGM5208.csv

    # SI1 files
    gawk '$1=$1' FIELDWIDTHS='12 8 80 12 30 30 25 2 14 5 2 10 12 30 30 25 2 14 2 1 15 1 15 12 30 30 25 2 14 2 15 6 15 45 80 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1000' OFS='|' $DPATH/$year/NYSI1208.fil > $OUTPUT_DPATH/$year/NYSI1208.csv

    # SI2 files
    gawk '$1=$1' FIELDWIDTHS='12 6 2 40 8 1 12 30 30 25 2 14 2 15 240' OFS='|' $DPATH/$year/NYSI2208.fil > $OUTPUT_DPATH/$year/NYSI2208.csv

    # SI3 files
    gawk '$1=$1' FIELDWIDTHS='12 4 6' OFS='|' $DPATH/$year/NYSI3208.fil > $OUTPUT_DPATH/$year/NYSI3208.csv

    # SI4 files
    gawk '$1=$1' FIELDWIDTHS='12 4' OFS='|' $DPATH/$year/NYSI4208.fil > $OUTPUT_DPATH/$year/NYSI4208.csv

    # SI5 files
    gawk '$1=$1' FIELDWIDTHS='12 6' OFS='|' $DPATH/$year/NYSI5208.fil > $OUTPUT_DPATH/$year/NYSI5208.csv

    # SI6 files
    gawk '$1=$1' FIELDWIDTHS='12 2 1 1 1' OFS='|' $DPATH/$year/NYSI6208.fil > $OUTPUT_DPATH/$year/NYSI6208.csv

    # SI7 files
    gawk '$1=$1' FIELDWIDTHS='12 6 15 1 15 45 8' OFS='|' $DPATH/$year/NYSI7208.fil > $OUTPUT_DPATH/$year/NYSI7208.csv

    # WR1 files
    gawk '$1=$1' FIELDWIDTHS='12 5 1 4 1 6 1 1 4 12 18 240 240' OFS='|' $DPATH/$year/NYWR1208.fil > $OUTPUT_DPATH/$year/NYWR1208.csv

    # WR2 files
    gawk '$1=$1' FIELDWIDTHS='12 5 1 4' OFS='|' $DPATH/$year/NYWR2208.fil > $OUTPUT_DPATH/$year/NYWR2208.csv

    # WR3 files
    gawk '$1=$1' FIELDWIDTHS='12 5 1 6' OFS='|' $DPATH/$year/NYWR3208.fil > $OUTPUT_DPATH/$year/NYWR3208.csv

    for file in $OUTPUT_DPATH/$year/*
    do
        # IMPORTANT: append year to each row in each file 
        echo "Appending years to file $file"
        sed -i "s/$/|"$year"/" $file

    done
done



