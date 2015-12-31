### ETL for RCRA Info ###

The ETL process is automated using Drake.

1. Download flat files from EPA FTP and unzip
2. The script `make_import_scripts.sh` uses the .xlsx files in the `data_dictionary` directory to make schemas to convert the flat files to CSVs and make create table statements. Here we use Python to clean the column names and write the files. 
3. Using these schemas and SQL scripts, we convert the flat files to CSVs and load each CSV as a table into the `rcra` schema in a PostgreSQL database.


This process assumes that the credentials for the PostgreSQL server have been specified in `default_profile`. 
