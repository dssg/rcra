#!/bin/bash

DPATH=$1

# download the ZIP shapefiles from the Census bureau 
curl -O http://www2.census.gov/geo/tiger/TIGER2007FE/fe_2007_us_state.zip > $DPATH
curl -O http://www2.census.gov/geo/tiger/GENZ2015/shp/cb_2015_us_zcta510_500k.zip > $DPATH

# unzip the files
unzip -u $DPATH/fe_2007_us_state.zip
unzip -u $DPATH/cb_2015_us_zcta510_500k.zip
