#!/bin/bash -xv

RCRA_DIR=$1

psql -f import/rcra/create_table_H.sql

echo loading hbasic into the database ...
in2csv -e iso-8859-1 -f fixed -s $RCRA_DIR/hbasic_schema.csv $RCRA_DIR/hbasic.txt | psql -c '\COPY rcra.hbasic FROM STDIN WITH CSV HEADER'
echo hbasic has been loaded into the database.

echo loading hcertification into the database ...
in2csv -e iso-8859-1 -f fixed -s $RCRA_DIR/hcertification_schema.csv $RCRA_DIR/hcertification.txt | psql -c '\COPY rcra.hcertification FROM STDIN WITH CSV HEADER'
echo hcertification has been loaded into the database.

echo loading hhandler into the database ...
in2csv -e iso-8859-1 -f fixed -s $RCRA_DIR/hhandler_schema.csv $RCRA_DIR/hhandler.txt | psql -c '\COPY rcra.hhandler FROM STDIN WITH CSV HEADER'
echo hhandler has been loaded into the database.

echo loading hnaics into the database ...
in2csv -e iso-8859-1 -f fixed -s $RCRA_DIR/hnaics_schema.csv $RCRA_DIR/hnaics.txt | psql -c '\COPY rcra.hnaics FROM STDIN WITH CSV HEADER'
echo hnaics has been loaded into the database.

echo loading hhsm_activity into the database ...
in2csv -e iso-8859-1 -f fixed -s $RCRA_DIR/hhsm_activity_schema.csv $RCRA_DIR/hhsm_activity.txt | psql -c '\COPY rcra.hhsm_activity FROM STDIN WITH CSV HEADER'
echo hhsm_activity has been loaded into the database.

echo loading hhsm_basic into the database ...
in2csv -e iso-8859-1 -f fixed -s $RCRA_DIR/hhsm_basic_schema.csv $RCRA_DIR/hhsm_basic.txt | psql -c '\COPY rcra.hhsm_basic FROM STDIN WITH CSV HEADER'
echo hhsm_basic has been loaded into the database.

echo loading hhsm_waste_code into the database ...
in2csv -e iso-8859-1 -f fixed -s $RCRA_DIR/hhsm_waste_code_schema.csv $RCRA_DIR/hhsm_waste_code.txt | psql -c '\COPY rcra.hhsm_waste_code FROM STDIN WITH CSV HEADER'
echo hhsm_waste_code has been loaded into the database.

echo loading hother_permit into the database ...
in2csv -e iso-8859-1 -f fixed -s $RCRA_DIR/hother_permit_schema.csv $RCRA_DIR/hother_permit.txt | psql -c '\COPY rcra.hother_permit FROM STDIN WITH CSV HEADER'
echo hother_permit has been loaded into the database.

echo loading howner_operator into the database ...
in2csv -e iso-8859-1 -f fixed -s $RCRA_DIR/howner_operator_schema.csv $RCRA_DIR/howner_operator.txt | psql -c '\COPY rcra.howner_operator FROM STDIN WITH CSV HEADER'
echo howner_operator has been loaded into the database.

echo loading hother_id into the database ...
in2csv -e iso-8859-1 -f fixed -s $RCRA_DIR/hother_id_schema.csv $RCRA_DIR/hother_id.txt | psql -c '\COPY rcra.hother_id FROM STDIN WITH CSV HEADER'
echo hother_id has been loaded into the database.

echo loading hpart_a into the database ...
in2csv -e iso-8859-1 -f fixed -s $RCRA_DIR/hpart_a_schema.csv $RCRA_DIR/hpart_a.txt | psql -c '\COPY rcra.hpart_a FROM STDIN WITH CSV HEADER'
echo hpart_a has been loaded into the database.

echo loading hreport_univ into the database ...
in2csv -e iso-8859-1 -f fixed -s $RCRA_DIR/hreport_univ_schema.csv $RCRA_DIR/hreport_univ.txt | psql -c '\COPY rcra.hreport_univ FROM STDIN WITH CSV HEADER'
echo hreport_univ has been loaded into the database.

echo loading hstate_activity into the database ...
in2csv -e iso-8859-1 -f fixed -s $RCRA_DIR/hstate_activity_schema.csv $RCRA_DIR/hstate_activity.txt | psql -c '\COPY rcra.hstate_activity FROM STDIN WITH CSV HEADER'
echo hstate_activity has been loaded into the database.

echo loading huniversal_waste into the database ...
in2csv -e iso-8859-1 -f fixed -s $RCRA_DIR/huniversal_waste_schema.csv $RCRA_DIR/huniversal_waste.txt | psql -c '\COPY rcra.huniversal_waste FROM STDIN WITH CSV HEADER'
echo huniversal_waste has been loaded into the database.

echo loading huniverse_detail into the database ...
in2csv -e iso-8859-1 -f fixed -s $RCRA_DIR/huniverse_detail_schema.csv $RCRA_DIR/huniverse_detail.txt | psql -c '\COPY rcra.huniverse_detail FROM STDIN WITH CSV HEADER'
echo huniverse_detail has been loaded into the database.

echo loading hwaste_code into the database ...
in2csv -e iso-8859-1 -f fixed -s $RCRA_DIR/hwaste_code_schema.csv $RCRA_DIR/hwaste_code.txt | psql -c '\COPY rcra.hwaste_code FROM STDIN WITH CSV HEADER'
echo hwaste_code has been loaded into the database.

echo loading lu_country into the database ...
in2csv -e iso-8859-1 -f fixed -s $RCRA_DIR/lu_country_schema.csv $RCRA_DIR/lu_country.txt | psql -c '\COPY rcra.lu_country FROM STDIN WITH CSV HEADER'
echo lu_country has been loaded into the database.

echo loading lu_county into the database ...
in2csv -e iso-8859-1 -f fixed -s $RCRA_DIR/lu_county_schema.csv $RCRA_DIR/lu_county.txt | psql -c '\COPY rcra.lu_county FROM STDIN WITH CSV HEADER'
echo lu_county has been loaded into the database.

echo loading lu_foreign_state into the database ...
in2csv -e iso-8859-1 -f fixed -s $RCRA_DIR/lu_foreign_state_schema.csv $RCRA_DIR/lu_foreign_state.txt | psql -c '\COPY rcra.lu_foreign_state FROM STDIN WITH CSV HEADER'
echo lu_foreign_state has been loaded into the database.

echo loading lu_generator_status into the database ...
in2csv -e iso-8859-1 -f fixed -s $RCRA_DIR/lu_generator_status_schema.csv $RCRA_DIR/lu_generator_status.txt | psql -c '\COPY rcra.lu_generator_status FROM STDIN WITH CSV HEADER'
echo lu_generator_status has been loaded into the database.

echo loading lu_hsm_facility_code into the database ...
in2csv -e iso-8859-1 -f fixed -s $RCRA_DIR/lu_hsm_facility_code_schema.csv $RCRA_DIR/lu_hsm_facility_code.txt | psql -c '\COPY rcra.lu_hsm_facility_code FROM STDIN WITH CSV HEADER'
echo lu_hsm_facility_code has been loaded into the database.

echo loading lu_naics into the database ...
in2csv -e iso-8859-1 -f fixed -s $RCRA_DIR/lu_naics_schema.csv $RCRA_DIR/lu_naics.txt | psql -c '\COPY rcra.lu_naics FROM STDIN WITH CSV HEADER'
echo lu_naics has been loaded into the database.

echo loading lu_other_permit into the database ...
in2csv -e iso-8859-1 -f fixed -s $RCRA_DIR/lu_other_permit_schema.csv $RCRA_DIR/lu_other_permit.txt | psql -c '\COPY rcra.lu_other_permit FROM STDIN WITH CSV HEADER'
echo lu_other_permit has been loaded into the database.

echo loading lu_relationship into the database ...
in2csv -e iso-8859-1 -f fixed -s $RCRA_DIR/lu_relationship_schema.csv $RCRA_DIR/lu_relationship.txt | psql -c '\COPY rcra.lu_relationship FROM STDIN WITH CSV HEADER'
echo lu_relationship has been loaded into the database.

echo loading lu_state into the database ...
in2csv -e iso-8859-1 -f fixed -s $RCRA_DIR/lu_state_schema.csv $RCRA_DIR/lu_state.txt | psql -c '\COPY rcra.lu_state FROM STDIN WITH CSV HEADER'
echo lu_state has been loaded into the database.

echo loading lu_state_activity into the database ...
in2csv -e iso-8859-1 -f fixed -s $RCRA_DIR/lu_state_activity_schema.csv $RCRA_DIR/lu_state_activity.txt | psql -c '\COPY rcra.lu_state_activity FROM STDIN WITH CSV HEADER'
echo lu_state_activity has been loaded into the database.

echo loading lu_state_district into the database ...
in2csv -e iso-8859-1 -f fixed -s $RCRA_DIR/lu_state_district_schema.csv $RCRA_DIR/lu_state_district.txt | psql -c '\COPY rcra.lu_state_district FROM STDIN WITH CSV HEADER'
echo lu_state_district has been loaded into the database.

echo loading lu_universal_waste into the database ...
in2csv -e iso-8859-1 -f fixed -s $RCRA_DIR/lu_universal_waste_schema.csv $RCRA_DIR/lu_universal_waste.txt | psql -c '\COPY rcra.lu_universal_waste FROM STDIN WITH CSV HEADER'
echo lu_universal_waste has been loaded into the database.

echo loading lu_waste_code into the database ...
in2csv -e iso-8859-1 -f fixed -s $RCRA_DIR/lu_waste_code_schema.csv $RCRA_DIR/lu_waste_code.txt | psql -c '\COPY rcra.lu_waste_code FROM STDIN WITH CSV HEADER'
echo lu_waste_code has been loaded into the database.

