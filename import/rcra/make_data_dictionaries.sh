#!/bin/bash -xv

# Where to find the data dictionaries
DIR_PATH=$1
OUTPUT_DIR=$2

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
    python import/rcra/xlsx2import.py $DIR_PATH"/"${dictionaries[$prefix]} $prefix $OUTPUT_DIR
done 
