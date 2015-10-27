### ETL for RCRA flat files ###



We obtain the RCRA flat files from the following ftp site: `ftp://ftp.epa.gov/rcrainfodata/rcra_flatfiles`

These files have historical inspection data, waste reporting, facility registration information, etc.

The script `make_import_scripts.sh` will generate schemas to convert the flat files to CSVs using the dictionaries in the `data_dictionary` directory, and create table statements for each dataset.

The script `import_rcra_data.sh` will load the tables into `rcra` schema in a PostgreSQL database. 

This script assumes that the credentials for the PostgreSQL server have been specified in `default_profile`. 
