#!/bin/bash
#set path to zip codes and shape files here
DPATH=$1
OUTPUT_DPATH=$2


#curl data

curl -O http://www2.census.gov/geo/tiger/TIGER2007FE/fe_2007_us_state.zip > $DPATH
curl -O http://www2.census.gov/geo/tiger/GENZ2015/shp/cb_2015_us_zcta510_500k.zip > $DPATH

#Include in Flood Hazard Data (had to download separately and upload; couldn't curl
##because couldn't curl, just downloaded, saved, converted to shape file, and will upload shape files to postgres from here

#create schema
eval $(cat psql_profile.config)



#Load zipcode data into postgress
# SRID_old: 4269 (US Census projection)
# SRID_new: 4326 (Google projection)
# -I is for the index

shp2pgsql -I -s 4269:4326 -d $DPATH/cb_2015_us_zcta510_500k geo.zipcode | psql 
shp2pgsql -I -s 4269:4326 -d $DPATH/fe_2007_us_state geo.states | psql 



#Ar files = Location and attributes flood insurance risk zones shown on the FIRM
##FEMA Firm Database Technical Reference available in the FEMA Library at http://www.fema.gov/media-library/assets/documents/34519
shp2pgsql -I -s 4269:4326 -d $DPATH/NFHL_36_20160712_Fld_Haz_Ar geo.floodhaz_ar | psql

#Ln files = Location and attributes for boundaries of flood insurance risk zones on the firm
shp2pgsql -I -s 4269:4326 -d $DPATH/NFHL_36_20160712_Fld_Haz_Ln geo.floodhaz_ln | psql



#Using ogr2ogr to get the flood hazard .gdb file into postgres
#ogr2ogr -f "PostgreSQL" PG:"nysdec = flood_hazard" -overwrite -progress NFHL_36-20160712.gdb

#include in NYC zip codes and cities list
cat $DPATH/NY_zipcodes.csv | psql -c "\copy geo.NY_zipcodelist FROM './NY_zipcodes.csv' with csv header;"


