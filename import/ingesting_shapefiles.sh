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
shp2pgsql -I -s 4269:4326 -d NFHL_36_20160712.zip | psql
