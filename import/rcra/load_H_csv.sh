#!/bin/bash -xv

RCRA_DIR=$1

echo loading hbasic into the database ...
cat $RCRA_DIR/H/hbasic.csv | psql -c '\COPY rcra.hbasic FROM STDIN WITH CSV HEADER'
echo hbasic has been loaded into the database.

echo loading hcertification into the database ...
cat $RCRA_DIR/H/hcertification.csv | psql -c '\COPY rcra.hcertification FROM STDIN WITH CSV HEADER'
echo hcertification has been loaded into the database.

echo loading hhandler into the database ...
cat $RCRA_DIR/H/hhandler.csv | psql -c '\COPY rcra.hhandler FROM STDIN WITH CSV HEADER'
echo hhandler has been loaded into the database.

echo loading hnaics into the database ...
cat $RCRA_DIR/H/hnaics.csv | psql -c '\COPY rcra.hnaics FROM STDIN WITH CSV HEADER'
echo hnaics has been loaded into the database.

echo loading hhsm_activity into the database ...
cat $RCRA_DIR/H/hhsm_activity.csv | psql -c '\COPY rcra.hhsm_activity FROM STDIN WITH CSV HEADER'
echo hhsm_activity has been loaded into the database.

echo loading hhsm_basic into the database ...
cat $RCRA_DIR/H/hhsm_basic.csv | psql -c '\COPY rcra.hhsm_basic FROM STDIN WITH CSV HEADER'
echo hhsm_basic has been loaded into the database.

echo loading hhsm_waste_code into the database ...
cat $RCRA_DIR/H/hhsm_waste_code.csv | psql -c '\COPY rcra.hhsm_waste_code FROM STDIN WITH CSV HEADER'
echo hhsm_waste_code has been loaded into the database.

echo loading hother_permit into the database ...
cat $RCRA_DIR/H/hother_permit.csv | psql -c '\COPY rcra.hother_permit FROM STDIN WITH CSV HEADER'
echo hother_permit has been loaded into the database.

echo loading howner_operator into the database ...
cat $RCRA_DIR/H/howner_operator.csv | psql -c '\COPY rcra.howner_operator FROM STDIN WITH CSV HEADER'
echo howner_operator has been loaded into the database.

echo loading hother_id into the database ...
cat $RCRA_DIR/H/hother_id.csv | psql -c '\COPY rcra.hother_id FROM STDIN WITH CSV HEADER'
echo hother_id has been loaded into the database.

echo loading hpart_a into the database ...
cat $RCRA_DIR/H/hpart_a.csv | psql -c '\COPY rcra.hpart_a FROM STDIN WITH CSV HEADER'
echo hpart_a has been loaded into the database.

echo loading hreport_univ into the database ...
cat $RCRA_DIR/H/hreport_univ.csv | psql -c '\COPY rcra.hreport_univ FROM STDIN WITH CSV HEADER'
echo hreport_univ has been loaded into the database.

echo loading hstate_activity into the database ...
cat $RCRA_DIR/H/hstate_activity.csv | psql -c '\COPY rcra.hstate_activity FROM STDIN WITH CSV HEADER'
echo hstate_activity has been loaded into the database.

echo loading huniversal_waste into the database ...
cat $RCRA_DIR/H/huniversal_waste.csv | psql -c '\COPY rcra.huniversal_waste FROM STDIN WITH CSV HEADER'
echo huniversal_waste has been loaded into the database.

echo loading huniverse_detail into the database ...
cat $RCRA_DIR/H/huniverse_detail.csv | psql -c '\COPY rcra.huniverse_detail FROM STDIN WITH CSV HEADER'
echo huniverse_detail has been loaded into the database.

echo loading hwaste_code into the database ...
cat $RCRA_DIR/H/hwaste_code.csv | psql -c '\COPY rcra.hwaste_code FROM STDIN WITH CSV HEADER'
echo hwaste_code has been loaded into the database.

echo loading lu_country into the database ...
cat $RCRA_DIR/H/lu_country.csv | psql -c '\COPY rcra.lu_country FROM STDIN WITH CSV HEADER'
echo lu_country has been loaded into the database.

echo loading lu_county into the database ...
cat $RCRA_DIR/H/lu_county.csv | psql -c '\COPY rcra.lu_county FROM STDIN WITH CSV HEADER'
echo lu_county has been loaded into the database.

echo loading lu_foreign_state into the database ...
cat $RCRA_DIR/H/lu_foreign_state.csv | psql -c '\COPY rcra.lu_foreign_state FROM STDIN WITH CSV HEADER'
echo lu_foreign_state has been loaded into the database.

echo loading lu_generator_status into the database ...
cat $RCRA_DIR/H/lu_generator_status.csv | psql -c '\COPY rcra.lu_generator_status FROM STDIN WITH CSV HEADER'
echo lu_generator_status has been loaded into the database.

echo loading lu_hsm_facility_code into the database ...
cat $RCRA_DIR/H/lu_hsm_facility_code.csv | psql -c '\COPY rcra.lu_hsm_facility_code FROM STDIN WITH CSV HEADER'
echo lu_hsm_facility_code has been loaded into the database.

echo loading lu_naics into the database ...
cat $RCRA_DIR/H/lu_naics.csv | psql -c '\COPY rcra.lu_naics FROM STDIN WITH CSV HEADER'
echo lu_naics has been loaded into the database.

echo loading lu_other_permit into the database ...
cat $RCRA_DIR/H/lu_other_permit.csv | psql -c '\COPY rcra.lu_other_permit FROM STDIN WITH CSV HEADER'
echo lu_other_permit has been loaded into the database.

echo loading lu_relationship into the database ...
cat $RCRA_DIR/H/lu_relationship.csv | psql -c '\COPY rcra.lu_relationship FROM STDIN WITH CSV HEADER'
echo lu_relationship has been loaded into the database.

echo loading lu_state into the database ...
cat $RCRA_DIR/H/lu_state.csv | psql -c '\COPY rcra.lu_state FROM STDIN WITH CSV HEADER'
echo lu_state has been loaded into the database.

echo loading lu_state_activity into the database ...
cat $RCRA_DIR/H/lu_state_activity.csv | psql -c '\COPY rcra.lu_state_activity FROM STDIN WITH CSV HEADER'
echo lu_state_activity has been loaded into the database.

echo loading lu_state_district into the database ...
cat $RCRA_DIR/H/lu_state_district.csv | psql -c '\COPY rcra.lu_state_district FROM STDIN WITH CSV HEADER'
echo lu_state_district has been loaded into the database.

echo loading lu_universal_waste into the database ...
cat $RCRA_DIR/H/lu_universal_waste.csv | psql -c '\COPY rcra.lu_universal_waste FROM STDIN WITH CSV HEADER'
echo lu_universal_waste has been loaded into the database.

echo loading lu_waste_code into the database ...
cat $RCRA_DIR/H/lu_waste_code.csv | psql -c '\COPY rcra.lu_waste_code FROM STDIN WITH CSV HEADER'
echo lu_waste_code has been loaded into the database.

