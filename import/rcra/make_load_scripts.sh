#!/bin/bash -xv

dir_path="/mnt/data/epa/import/rcra/data_dictionary/" 

declare -A dictionaries
dictionaries[A]="Flat_File_Specification_A_Corrective_Action.xlsx"
dictionaries[C]="Flat_File_Specification_Compliance_Monitoring_and_Enforcement_Module.xlsx"
dictionaries[F]="Flat_File_Specification_Financial_Assurance.xlsx"
dictionaries[gis]="Flat_File_Specification_GIS_Module.xlsx"
dictionaries[H]="Flat_File_Specification_Handler_Module.xlsx"
dictionaries[P]="Flat_File_Specification_P_Permit_Closure_and_Post-Closure_Module.xlsx"
dictionaries[BR]="Flat_File_Specification_Waste_Activity_Monitoring_Module.xlsx"

for prefix in "${!dictionaries[@]}"
do
#    echo $dir_path"/"${dictionaries[$prefix]} $prefix 
    python xlsx2csv.py $dir_path"/"${dictionaries[$prefix]} $prefix
done 
