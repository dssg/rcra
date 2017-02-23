### ETL for RCRA Info ###

The RCRAInfo system allows tracking of many types of information about the regulated universe of RCRA hazardous waste handlers. RCRAInfo characterizes facility status, regulated activities, and compliance histories and captures detailed data on the generation of hazardous waste from large quantity generators and on waste management practices from treatment, storage, and disposal facilities.

RCRA Info files are organized by module: handler (H), permit (P), corrective action (A), compliance monitoring and enforcement (C), waste activity monitoring (BR), and GIS. Each module contains several different datasets. The column names and lengths are specified in the data dictionaries, which are .xslx spreadsheets generated from the RCRA Info flat file documentation PDF.

The ETL process for RCRA Info is as follows:

1. For each module, use the specification sheets to generate schema data and CREATE TABLE script for each table.

2. For each table:

    a) Download and unzip the flat file data from the EPA ftp
    b) Convert the data from flat file to CSV using in2csv
    c) Import the data using PostgreSQL COPY

The ETL process is automated using Drake. This process assumes that the credentials for the PostgreSQL server have been specified in `default_profile`. 
