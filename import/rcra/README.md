### ETL for RCRA Info ###

The RCRAInfo system allows tracking of many types of information about the regulated universe of RCRA hazardous waste handlers. RCRAInfo characterizes facility status, regulated activities, and compliance histories and captures detailed data on the generation of hazardous waste from large quantity generators and on waste management practices from treatment, storage, and disposal facilities.

RCRA Info files are organized by module: handler (H), permit (P), corrective action (A), compliance monitoring and enforcement (C), waste activity monitoring (BR), and GIS. Each module contains several different datasets. The column names and lengths are specified in the data dictionaries, which are .xslx spreadsheets generated from the RCRA Info flat file documentation PDF.

The ETL process for RCRA Info is as follows:

1. Download flat files from EPA FTP and unzip
2. The script `make_import_scripts.sh` uses the .xlsx files for each module in the `data_dictionary` directory to write schemas to convert the flat files to CSVs and write a SQL script containing create table statements. Here we use Python to clean the column names and write the files. 
3. Using these schemas and SQL scripts, we convert the flat files to CSVs and load each CSV as a table into the `rcra` schema in a PostgreSQL database.

The ETL process is automated using Drake. This process assumes that the credentials for the PostgreSQL server have been specified in `default_profile`. 
