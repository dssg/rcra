### ETL for Integrated Compliance Information System (ICIS) ###

ICIS data sets are part of the EPA's Enforcement and Compliance History Online (ECHO) system, and are updated weekly. They are categorized into three file types: 

* *AIR* contains emissions, compliance, and enforcement data on stationary sources of air pollution. Regulated sources cover a wide spectrum; from large industrial facilities to relatively small operations such as dry cleaners (automobiles and other mobile air pollution sources are tracked by a different EPA system).
* *FEC* (Federal Enforcement and Compliance) tracks federal enforcement cases under the Clean Air Act (CAA), the Clean Water Act (CWA), the Resource Conservation and Recovery Act (RCRA), the Emergency Planning and Community Right-to-Know Act (EPCRA) Section 313, the Toxic Substances Control Act (TSCA), the Federal Insecticide, Fungicide, and Rodenticide Act (FIFRA), the Comprehensive Environmental Response, Compensation, and Liability Act (CERCLA or Superfund), the Safe Drinking Water Act (SDWA), and the Marine Protection, Research, and Sanctuaries Act (MPRSA).
* *NPDES* (National Pollutant Discharge and Elimination System) tracks permit compliance and enforcement status of facilities regulated by the National Pollutant Discharge Elimination System (NPDES) under the Clean Water Act (CWA).

ETL for ICIS is as follows:

1. Download and unzip files from FTP
2. Create *air*, *fec*, and *npdes* schemas in PostgreSQL database and create corresponding tables
2. Standardize file names to have one of the three prefixes 
3. Load CSVs into data base 
