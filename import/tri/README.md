### ETL for Toxics Release Inventory (TRI) ###

TRI files contain all the data that were submitted on the TRI Reporting Form R or Certification Statement (Form
A) between 1987 and 2013. If a facility is within a certain sector (determined by NAICS code), employs 10 or more full time employees, and processes TRI-listed chemicals above a certain threshold in a given year, that facility is required to report. Within each year, TRI data is categorized into eight file types: 

* *1* Facility data, Chemical identification, Chemical uses, On-site Releases and Management, Off-site Transfers, Summary Information
* *2a* Detailed Source Reduction and Recycling Activities 
* *2b* Detailed Waste Management
* *3a* Details of Transfers Off-Site
* *3b* Details of Transfers to Publicly Owned Treatment Works (POTW) 
* *4* Facility Information Directory
* *5* Additional Information on Source Reduction, Recycling and Pollution Control
* *6* Miscellaneous, Additional, or Optional Information

The ETL process for TRI is as follows:

1. For each year, download and unzip the set of eight files from FTP
2. For each file type, merge all text files for all years into one file and convert to CSV
3. Create TRI schema with one table for each file type
4. Load CSVs into data base 
