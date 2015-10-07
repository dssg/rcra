#!/bin/bash -xv

# This script will download the data from the EPA ftp site and
# create the load scripts and SQL statements.
# It will finally load all the files into the PostgreSQL database.

# Get all the data files from the ftp site
wget -P /mnt/data/epa/import/rcra/ ftp://ftp.epa.gov/rcrainfodata/rcra_flatfiles/*.gz

# Unzip the files
gunzip /mnt/data/epa/import/rcra/*.gz

