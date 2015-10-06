### ETL for RCRA flat files ###

We obtain the RCRA flat files for the following ftp site: `ftp://ftp.epa.gov/rcrainfodata/rcra_flatfiles`

These files have historical inspection data, waste reporting, facility registration inofrmation etc.

The script `load_rcra_data.sh` will create corresponding tables for each dataset and load it into a PostgreSQL. 

This script assumes that the credentials for the PostgreSQL server have been specified in the `ENV` variables. 

Script suffixes correspond to Modules as follows:

```
A => Flat_File_Specification_A_Corrective_Action.xlsx
C => Flat_File_Specification_Compliance_Monitoring_and_Enforcement_Module.xlsx
F => Flat_File_Specification_Financial_Assurance.xlsx
gis => Flat_File_Specification_GIS_Module.xlsx
H => Flat_File_Specification_Handler_Module.xlsx
P => Flat_File_Specification_P_Permit_Closure_and_Post-Closure_Module.xlsx
BR => Flat_File_Specification_Waste_Activity_Monitoring_Module.xlsx
```
