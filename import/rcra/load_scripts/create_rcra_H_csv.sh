#!/bin/bash                                                                  

RCRA_DIR=$1
DICT_DIR=$2
OUTPUT_DIR=$3

in2csv -e iso-8859-1 -f fixed -s $DICT_DIR/hbasic_schema.csv $RCRA_DIR/hbasic.txt > $OUTPUT_DIR/hbasic.csv

in2csv -e iso-8859-1 -f fixed -s $DICT_DIR/hcertification_schema.csv $RCRA_DIR/hcertification.txt > $OUTPUT_DIR/hcertification.csv

in2csv -e iso-8859-1 -f fixed -s $DICT_DIR/hhandler_schema.csv $RCRA_DIR/hhandler.txt > $OUTPUT_DIR/hhandler.csv

in2csv -e iso-8859-1 -f fixed -s $DICT_DIR/hnaics_schema.csv $RCRA_DIR/hnaics.txt > $OUTPUT_DIR/hnaics.csv

in2csv -e iso-8859-1 -f fixed -s $DICT_DIR/hhsm_activity_schema.csv $RCRA_DIR/hhsm_activity.txt > $OUTPUT_DIR/hhsm_activity.csv

in2csv -e iso-8859-1 -f fixed -s $DICT_DIR/hhsm_basic_schema.csv $RCRA_DIR/hhsm_basic.txt > $OUTPUT_DIR/hhsm_basic.csv 

in2csv -e iso-8859-1 -f fixed -s $DICT_DIR/hhsm_waste_code_schema.csv $RCRA_DIR/hhsm_waste_code.txt > $OUTPUT_DIR/hhsm_waste_code.csv

in2csv -e iso-8859-1 -f fixed -s $DICT_DIR/hother_permit_schema.csv $RCRA_DIR/hother_permit.txt > $OUTPUT_DIR/hother_permit.csv

in2csv -e iso-8859-1 -f fixed -s $DICT_DIR/howner_operator_schema.csv $RCRA_DIR/howner_operator.txt > $OUTPUT_DIR/howner_operator.csv

in2csv -e iso-8859-1 -f fixed -s $DICT_DIR/hother_id_schema.csv $RCRA_DIR/hother_id.txt > $OUTPUT_DIR/hother_id.csv 

in2csv -e iso-8859-1 -f fixed -s $DICT_DIR/hpart_a_schema.csv $RCRA_DIR/hpart_a.txt > $OUTPUT_DIR/hpart_a.csv

in2csv -e iso-8859-1 -f fixed -s $DICT_DIR/hreport_univ_schema.csv $RCRA_DIR/hreport_univ.txt > $OUTPUT_DIR/hreport_univ.csv

in2csv -e iso-8859-1 -f fixed -s $DICT_DIR/hstate_activity_schema.csv $RCRA_DIR/hstate_activity.txt > $OUTPUT_DIR/hstate_activity.csv

in2csv -e iso-8859-1 -f fixed -s $DICT_DIR/huniversal_waste_schema.csv $RCRA_DIR/huniversal_waste.txt > $OUTPUT_DIR/huniversal_waste.csv

in2csv -e iso-8859-1 -f fixed -s $DICT_DIR/huniverse_detail_schema.csv $RCRA_DIR/huniverse_detail.txt > $OUTPUT_DIR/huniverse_detail.csv

in2csv -e iso-8859-1 -f fixed -s $DICT_DIR/hwaste_code_schema.csv $RCRA_DIR/hwaste_code.txt > $OUTPUT_DIR/hwaste_code.csv

in2csv -e iso-8859-1 -f fixed -s $DICT_DIR/lu_country_schema.csv $RCRA_DIR/lu_country.txt > $OUTPUT_DIR/lu_country.csv

in2csv -e iso-8859-1 -f fixed -s $DICT_DIR/lu_county_schema.csv $RCRA_DIR/lu_county.txt > $OUTPUT_DIR/lu_county.csv

in2csv -e iso-8859-1 -f fixed -s $DICT_DIR/lu_foreign_state_schema.csv $RCRA_DIR/lu_foreign_state.txt > $OUTPUT_DIR/lu_foreign_state.csv

in2csv -e iso-8859-1 -f fixed -s $DICT_DIR/lu_generator_status_schema.csv $RCRA_DIR/lu_generator_status.txt > $OUTPUT_DIR/lu_generator_status.csv

in2csv -e iso-8859-1 -f fixed -s $DICT_DIR/lu_hsm_facility_code_schema.csv $RCRA_DIR/lu_hsm_facility_code.txt > $OUTPUT_DIR/lu_hsm_facility_code.csv

in2csv -e iso-8859-1 -f fixed -s $DICT_DIR/lu_naics_schema.csv $RCRA_DIR/lu_naics.txt > $OUTPUT_DIR/lu_naics.csv

in2csv -e iso-8859-1 -f fixed -s $DICT_DIR/lu_other_permit_schema.csv $RCRA_DIR/lu_other_permit.txt > $OUTPUT_DIR/lu_other_permit.csv

in2csv -e iso-8859-1 -f fixed -s $DICT_DIR/lu_relationship_schema.csv $RCRA_DIR/lu_relationship.txt > $OUTPUT_DIR/lu_relationship.csv

in2csv -e iso-8859-1 -f fixed -s $DICT_DIR/lu_state_schema.csv $RCRA_DIR/lu_state.txt > $OUTPUT_DIR/lu_state.csv

in2csv -e iso-8859-1 -f fixed -s $DICT_DIR/lu_state_activity_schema.csv $RCRA_DIR/lu_state_activity.txt > $OUTPUT_DIR/lu_state_activity.csv

in2csv -e iso-8859-1 -f fixed -s $DICT_DIR/lu_state_district_schema.csv $RCRA_DIR/lu_state_district.txt > $OUTPUT_DIR/lu_state_district.csv

in2csv -e iso-8859-1 -f fixed -s $DICT_DIR/lu_universal_waste_schema.csv $RCRA_DIR/lu_universal_waste.txt > $OUTPUT_DIR/lu_universal_waste.csv

in2csv -e iso-8859-1 -f fixed -s $DICT_DIR/lu_waste_code_schema.csv $RCRA_DIR/lu_waste_code.txt > $OUTPUT_DIR/lu_waste_code.csv
