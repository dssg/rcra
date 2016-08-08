#!/bin/bash


#curl data

curl -O http://www2.census.gov/geo/tiger/TIGER2007FE/fe_2007_us_state.zip
curl -O http://www2.census.gov/geo/tiger/GENZ2015/shp/cb_2015_us_zcta510_500k.zip

#Include in Flood Hazard Data (had to download separately and upload; couldn't curl


#Load zipcode data into postgress
# SRID_old: 4269 (US Census projection)
# SRID_new: 4326 (Google projection)
# -I is for the index

shp2pgsql -I -s 4269:4326 -d cb_2015_us_zcta510_500k geo.zipcode | psql 
shp2pgsql -I -s 4269:4326 -d fe_2007_us_state geo.states | psql 

#Using ogr2ogr to get the flood hazard .gdb file into postgres
#ogr2ogr -f "PostgreSQL" PG:"nysdec = flood_hazard" -overwrite -progress NFHL_36-20160712.gdb





#include in NYC zip codes and cities list

cat NY_zipcodes.csv | psql -c "\copy geo.NY_zipcodelist FROM './NY_zipcodes.csv' with csv header;"


