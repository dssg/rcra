#!/bin/bash

# set path to NYSDEC BR data here
DPATH=$1
OUTPUT_DPATH=$2

# unzip the files
for year in 2006 2007 2008 2009 2010 2011 2012 2013 2014 2015
do
    unzip -f $DPATH/$year.zip -d $DPATH/$year
done

# convert fixed-width to CSV
for year in 2006 2007 2008 2009 2010 2011 2012 2013 2014 2015
do
    mkdir -p $DPATH/$year/csv

    # GM1 files
    gawk '$1=$1' FIELDWIDTHS='12 5 4 1 6 1 4 1 3 18 1 240 240 1 1' OFS=, $DPATH/$year/NYGM1208.fil > $DPATH/$year/csv/NYGM1208.csv

    # GM2 files
    gawk '$1=$1' FIELDWIDTHS='12 5 4' OFS=, $DPATH/$year/NYGM2208.fil > $DPATH/$year/csv/NYGM2208.csv

    # GM3 files
    gawk '$1=$1' FIELDWIDTHS='12 5 6' OFS=, $DPATH/$year/NYGM3208.fil > $DPATH/$year/csv/NYGM3208.csv

    # GM4 files
    gawk '$1=$1' FIELDWIDTHS='12 5 5 4 12 18' OFS=, $DPATH/$year/NYGM4208.fil > $DPATH/$year/csv/NYGM4208.csv

    # GM5 files
    gawk '$1=$1' FIELDWIDTHS='12 5 5 4 18' OFS=, $DPATH/$year/NYGM5208.fil > $DPATH/$year/csv/NYGM5208.csv

    # SI1 files
    gawk '$1=$1' FIELDWIDTHS='12 8 80 12 30 30 25 2 14 5 2 10 12 30 30 25 2 14 2 1 15 1 15 12 30 30 25 2 14 2 15 6 15 45 80 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1000' OFS=, $DPATH/$year/NYSI1208.fil > $DPATH/$year/csv/NYSI1208.csv

    # SI2 files
    gawk '$1=$1' FIELDWIDTHS='12 6 2 40 8 1 12 30 30 25 2 14 2 15 240' OFS=, $DPATH/$year/NYSI2208.fil > $DPATH/$year/csv/NYSI2208.csv

    # SI3 files
    gawk '$1=$1' FIELDWIDTHS='12 4 6' OFS=, $DPATH/$year/NYSI3208.fil > $DPATH/$year/csv/NYSI3208.csv

    # SI4 files
    gawk '$1=$1' FIELDWIDTHS='12 4' OFS=, $DPATH/$year/NYSI4208.fil > $DPATH/$year/csv/NYSI4208.csv

    # SI5 files
    gawk '$1=$1' FIELDWIDTHS='12 6' OFS=, $DPATH/$year/NYSI5208.fil > $DPATH/$year/csv/NYSI5208.csv

    # SI6 files
    gawk '$1=$1' FIELDWIDTHS='12 2 1 1 1' OFS=, $DPATH/$year/NYSI6208.fil > $DPATH/$year/csv/NYSI6208.csv

    # SI7 files
    gawk '$1=$1' FIELDWIDTHS='12 6 15 1 15 45 8' OFS=, $DPATH/$year/NYSI7208.fil > $DPATH/$year/csv/NYSI7208.csv

    # WR1 files
    gawk '$1=$1' FIELDWIDTHS='12 5 1 4 1 6 1 1 4 12 18 240 240' OFS=, $DPATH/$year/NYWR1208.fil > $DPATH/$year/csv/NYWR1208.csv

    # WR2 files
    gawk '$1=$1' FIELDWIDTHS='12 5 1 4' OFS=, $DPATH/$year/NYWR2208.fil > $DPATH/$year/csv/NYWR2208.csv

    # WR3 files
    gawk '$1=$1' FIELDWIDTHS='12 5 1 6' OFS=, $DPATH/$year/NYWR3208.fil > $DPATH/$year/csv/NYWR3208.csv

    # IMPORTANT: append year to each row in each file so that we can have one table for each type
    for file in $DPATH/$year/csv/*
    do
        sed "s/$/,"$year"/" $DPATH/$year/csv/$file
    done
done



