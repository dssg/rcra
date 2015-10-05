#!/bin/bash -xv

# This script will download & unzip the ICIS data 
# Have not added the Limit & DMR data 

# Get ICIS AIR data
wget -P $1 https://echo.epa.gov/files/echodownloads/ICIS-AIR_downloads.zip

# Get ICIS NPDES data 
#wget -P $1 https://echo.epa.gov/files/echodownloads/npdes_downloads.zip
#wget -P $1 https://echo.epa.gov/files/echodownloads/npdes_eff_downloads.zip

# Get ICIS FE&C data 
#wget -P $1 https://echo.epa.gov/files/echodownloads/case_downloads.zip

# Unzip the files
#unzip \*.zip
