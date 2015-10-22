### ETL for RCRA flat files ###

We obtain the RCRA flat files for the following ftp site: `ftp://ftp.epa.gov/rcrainfodata/rcra_flatfiles`

These files have historical inspection data, waste reporting, facility registration inofrmation etc.

The script `make_load_scripts.sh` will generate create table statements for each dataset.
The script `import_rcra_data.sh` will load the tables into a PostgreSQL database. 

This script assumes that the credentials for the PostgreSQL server have been specified in `default_profile`. 
