#!/bin/bash -xv

dir_path=$1
output_dir=$2 

declare -A dictionaries
dictionaries[A]="Flat_File_Specification_A_Corrective_Action.xlsx"
dictionaries[C]="Flat_File_Specification_Compliance_Monitoring_and_Enforcement_Module.xlsx"
dictionaries[F]="Flat_File_Specification_Financial_Assurance.xlsx"
dictionaries[GIS]="Flat_File_Specification_GIS_Module.xlsx"
dictionaries[H]="Flat_File_Specification_Handler_Module.xlsx"
dictionaries[P]="Flat_File_Specification_P_Permit_Closure_and_Post-Closure_Module.xlsx"
dictionaries[BR]="Flat_File_Specification_Waste_Activity_Monitoring_Module.xlsx"

for prefix in "${!dictionaries[@]}"
do
<<<<<<< HEAD
    python import/rcra/xlsx2import.py $dir_path"/"${dictionaries[$prefix]} $prefix $output_dir
=======
    python xlsx2import.py $dir_path"/"${dictionaries[$prefix]} $output_dir
>>>>>>> c89eadb0a5f87df0055272599c4f5fdd0c80ecd3
done 
