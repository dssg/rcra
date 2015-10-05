### ETL for RCRA flat files ###

We obtain the RCRA flat files for the following ftp site: `ftp://ftp.epa.gov/rcrainfodata/rcra_flatfiles`

These files have historical inspection data, waste reporting, facility registration inofrmation etc.

The script `load_rcra_data.sh` will create corresponding tables for each dataset and load it into a PostgreSQL. 

This script assumes that the credentials for the PostgreSQL server have been specified in the `ENV` variables. 
