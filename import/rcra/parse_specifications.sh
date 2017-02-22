#!/bin/bash

mkdir -p $OUTPUT/schema $OUTPUT/create
rm -f $OUTPUT/schema/* $OUTPUT/create/*

declare -A dictionaries

# Corrective Action and Permit modules have changed on the FTP site
#dictionaries[A]="Flat_File_Specification_A_Corrective_Action.xlsx"
dictionaries[C]="Flat_File_Specification_Compliance_Monitoring_and_Enforcement_Module.xlsx"
dictionaries[F]="Flat_File_Specification_Financial_Assurance.xlsx"
dictionaries[GIS]="Flat_File_Specification_GIS_Module.xlsx"
dictionaries[H]="Flat_File_Specification_Handler_Module.xlsx"
#dictionaries[P]="Flat_File_Specification_P_Permit_Closure_and_Post-Closure_Module.xlsx"
dictionaries[BR]="Flat_File_Specification_Waste_Activity_Monitoring_Module.xlsx"

for prefix in "${!dictionaries[@]}"
do
    python import/rcra/xlsx2import.py $INPUT1"/"${dictionaries[$prefix]} $OUTPUT
done 
