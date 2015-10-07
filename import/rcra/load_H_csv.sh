#!/bin/bash -xv

psql -f drop_table_H.sql
psql -f create_table_H.sql

echo loading hbasic into the database ...
in2csv -e iso-8859-1 -f fixed -s hbasic_schema.csv /mnt/data/epa/RCRA_flat_files/hbasic.txt | psql -c '\COPY hbasic FROM STDIN WITH CSV HEADER'
echo hbasic has been loaded into the database.

echo loading hcertification into the database ...
in2csv -e iso-8859-1 -f fixed -s hcertification_schema.csv /mnt/data/epa/RCRA_flat_files/hcertification.txt | psql -c '\COPY hcertification FROM STDIN WITH CSV HEADER'
echo hcertification has been loaded into the database.

echo loading hhandler into the database ...
in2csv -e iso-8859-1 -f fixed -s hhandler_schema.csv /mnt/data/epa/RCRA_flat_files/hhandler.txt | psql -c '\COPY hhandler FROM STDIN WITH CSV HEADER'
echo hhandler has been loaded into the database.

echo loading hnaics into the database ...
in2csv -e iso-8859-1 -f fixed -s hnaics_schema.csv /mnt/data/epa/RCRA_flat_files/hnaics.txt | psql -c '\COPY hnaics FROM STDIN WITH CSV HEADER'
echo hnaics has been loaded into the database.

echo loading hhsm_activity into the database ...
in2csv -e iso-8859-1 -f fixed -s hhsm_activity_schema.csv /mnt/data/epa/RCRA_flat_files/hhsm_activity.txt | psql -c '\COPY hhsm_activity FROM STDIN WITH CSV HEADER'
echo hhsm_activity has been loaded into the database.

echo loading hhsm_basic into the database ...
in2csv -e iso-8859-1 -f fixed -s hhsm_basic_schema.csv /mnt/data/epa/RCRA_flat_files/hhsm_basic.txt | psql -c '\COPY hhsm_basic FROM STDIN WITH CSV HEADER'
echo hhsm_basic has been loaded into the database.

echo loading hhsm_waste_code into the database ...
in2csv -e iso-8859-1 -f fixed -s hhsm_waste_code_schema.csv /mnt/data/epa/RCRA_flat_files/hhsm_waste_code.txt | psql -c '\COPY hhsm_waste_code FROM STDIN WITH CSV HEADER'
echo hhsm_waste_code has been loaded into the database.

echo loading hother_permit into the database ...
in2csv -e iso-8859-1 -f fixed -s hother_permit_schema.csv /mnt/data/epa/RCRA_flat_files/hother_permit.txt | psql -c '\COPY hother_permit FROM STDIN WITH CSV HEADER'
echo hother_permit has been loaded into the database.

echo loading howner_operator into the database ...
in2csv -e iso-8859-1 -f fixed -s howner_operator_schema.csv /mnt/data/epa/RCRA_flat_files/howner_operator.txt | psql -c '\COPY howner_operator FROM STDIN WITH CSV HEADER'
echo howner_operator has been loaded into the database.

echo loading hother_id into the database ...
in2csv -e iso-8859-1 -f fixed -s hother_id_schema.csv /mnt/data/epa/RCRA_flat_files/hother_id.txt | psql -c '\COPY hother_id FROM STDIN WITH CSV HEADER'
echo hother_id has been loaded into the database.

echo loading hpart_a into the database ...
in2csv -e iso-8859-1 -f fixed -s hpart_a_schema.csv /mnt/data/epa/RCRA_flat_files/hpart_a.txt | psql -c '\COPY hpart_a FROM STDIN WITH CSV HEADER'
echo hpart_a has been loaded into the database.

echo loading hreport_univ into the database ...
in2csv -e iso-8859-1 -f fixed -s hreport_univ_schema.csv /mnt/data/epa/RCRA_flat_files/hreport_univ.txt | psql -c '\COPY hreport_univ FROM STDIN WITH CSV HEADER'
echo hreport_univ has been loaded into the database.

echo loading hstate_activity into the database ...
in2csv -e iso-8859-1 -f fixed -s hstate_activity_schema.csv /mnt/data/epa/RCRA_flat_files/hstate_activity.txt | psql -c '\COPY hstate_activity FROM STDIN WITH CSV HEADER'
echo hstate_activity has been loaded into the database.

echo loading huniversal_waste into the database ...
in2csv -e iso-8859-1 -f fixed -s huniversal_waste_schema.csv /mnt/data/epa/RCRA_flat_files/huniversal_waste.txt | psql -c '\COPY huniversal_waste FROM STDIN WITH CSV HEADER'
echo huniversal_waste has been loaded into the database.

echo loading huniverse_detail into the database ...
in2csv -e iso-8859-1 -f fixed -s huniverse_detail_schema.csv /mnt/data/epa/RCRA_flat_files/huniverse_detail.txt | psql -c '\COPY huniverse_detail FROM STDIN WITH CSV HEADER'
echo huniverse_detail has been loaded into the database.

echo loading hwaste_code into the database ...
in2csv -e iso-8859-1 -f fixed -s hwaste_code_schema.csv /mnt/data/epa/RCRA_flat_files/hwaste_code.txt | psql -c '\COPY hwaste_code FROM STDIN WITH CSV HEADER'
echo hwaste_code has been loaded into the database.

echo loading lu_country into the database ...
in2csv -e iso-8859-1 -f fixed -s lu_country_schema.csv /mnt/data/epa/RCRA_flat_files/lu_country.txt | psql -c '\COPY lu_country FROM STDIN WITH CSV HEADER'
echo lu_country has been loaded into the database.

echo loading lu_county into the database ...
in2csv -e iso-8859-1 -f fixed -s lu_county_schema.csv /mnt/data/epa/RCRA_flat_files/lu_county.txt | psql -c '\COPY lu_county FROM STDIN WITH CSV HEADER'
echo lu_county has been loaded into the database.

echo loading lu_foreign_state into the database ...
in2csv -e iso-8859-1 -f fixed -s lu_foreign_state_schema.csv /mnt/data/epa/RCRA_flat_files/lu_foreign_state.txt | psql -c '\COPY lu_foreign_state FROM STDIN WITH CSV HEADER'
echo lu_foreign_state has been loaded into the database.

echo loading lu_generator_status into the database ...
in2csv -e iso-8859-1 -f fixed -s lu_generator_status_schema.csv /mnt/data/epa/RCRA_flat_files/lu_generator_status.txt | psql -c '\COPY lu_generator_status FROM STDIN WITH CSV HEADER'
echo lu_generator_status has been loaded into the database.

echo loading lu_hsm_facility_code into the database ...
in2csv -e iso-8859-1 -f fixed -s lu_hsm_facility_code_schema.csv /mnt/data/epa/RCRA_flat_files/lu_hsm_facility_code.txt | psql -c '\COPY lu_hsm_facility_code FROM STDIN WITH CSV HEADER'
echo lu_hsm_facility_code has been loaded into the database.

echo loading lu_naics into the database ...
in2csv -e iso-8859-1 -f fixed -s lu_naics_schema.csv /mnt/data/epa/RCRA_flat_files/lu_naics.txt | psql -c '\COPY lu_naics FROM STDIN WITH CSV HEADER'
echo lu_naics has been loaded into the database.

echo loading lu_other_permit into the database ...
in2csv -e iso-8859-1 -f fixed -s lu_other_permit_schema.csv /mnt/data/epa/RCRA_flat_files/lu_other_permit.txt | psql -c '\COPY lu_other_permit FROM STDIN WITH CSV HEADER'
echo lu_other_permit has been loaded into the database.

echo loading lu_relationship into the database ...
in2csv -e iso-8859-1 -f fixed -s lu_relationship_schema.csv /mnt/data/epa/RCRA_flat_files/lu_relationship.txt | psql -c '\COPY lu_relationship FROM STDIN WITH CSV HEADER'
echo lu_relationship has been loaded into the database.

echo loading lu_state into the database ...
in2csv -e iso-8859-1 -f fixed -s lu_state_schema.csv /mnt/data/epa/RCRA_flat_files/lu_state.txt | psql -c '\COPY lu_state FROM STDIN WITH CSV HEADER'
echo lu_state has been loaded into the database.

echo loading lu_state_activity into the database ...
in2csv -e iso-8859-1 -f fixed -s lu_state_activity_schema.csv /mnt/data/epa/RCRA_flat_files/lu_state_activity.txt | psql -c '\COPY lu_state_activity FROM STDIN WITH CSV HEADER'
echo lu_state_activity has been loaded into the database.

echo loading lu_state_district into the database ...
in2csv -e iso-8859-1 -f fixed -s lu_state_district_schema.csv /mnt/data/epa/RCRA_flat_files/lu_state_district.txt | psql -c '\COPY lu_state_district FROM STDIN WITH CSV HEADER'
echo lu_state_district has been loaded into the database.

echo loading lu_universal_waste into the database ...
in2csv -e iso-8859-1 -f fixed -s lu_universal_waste_schema.csv /mnt/data/epa/RCRA_flat_files/lu_universal_waste.txt | psql -c '\COPY lu_universal_waste FROM STDIN WITH CSV HEADER'
echo lu_universal_waste has been loaded into the database.

echo loading lu_waste_code into the database ...
in2csv -e iso-8859-1 -f fixed -s lu_waste_code_schema.csv /mnt/data/epa/RCRA_flat_files/lu_waste_code.txt | psql -c '\COPY lu_waste_code FROM STDIN WITH CSV HEADER'
echo lu_waste_code has been loaded into the database.

