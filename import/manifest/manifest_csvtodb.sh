#!/bin/bash

# set path to waste manifests here
DPATH=$1
OUTPUT_DPATH=$2


# BEFORE ANYTHING: some of the state ID's already contain commas.
# convert these to colons so as not to fuck with the CSV stuff below
clean='_clean'
for f in man8081 mani82 mani83 mani84 mani85 mani86 mani87 mani88 mani89 mani90 mani91 mani92 mani93 mani94 mani95 mani96 mani97 mani98 mani99 mani00 mani01 mani02 mani03 mani04 mani05 
do
	cat $DPATH/$f.txt | tr ',' ':' > $DPATH/$f$clean.txt 
done


# converted fixed-width to CSV based on the format csv files
for f in man8081 mani82 mani83 mani84 mani85 mani86 mani87 mani88 mani89
do
	gawk '$1=$1' FIELDWIDTHS='10 1 9 9 6 6 6 6 6 6 12 12 12 12 4 5 1 3 2 1 3 4 5 1 3 2 1 3 4 5 1 3 2 1 3 4 5 1 3 2 1 3 4 5 1 3 2 1 3 4 5 1 3 2 1 3' OFS=, $DPATH/$f$clean.txt > $DPATH/$f_intermed.csv
done

for f in mani90 mani91 mani92 mani93 mani94 mani95 mani96 mani97 mani98 mani99 mani00 mani01 mani02 mani03 mani04 mani05
do
	gawk '$1=$1' FIELDWIDTHS='10 2 12 10 12 10 12 9 10 12 9 10 3 2 5 1 5 1 4 4 4 4 4 3 2 5 1 5 1 4 4 4 4 4 3 2 5 1 5 1 4 4 4 4 4 3 2 5 1 5 1 4 4 4 4 4' OFS=, $DPATH/$f$clean.txt > $DPATH/$f_intermed.csv
done

# append headers to the newly-made CSV's
header='_header'
for f in man8081 mani82 mani83 mani84 mani85 mani86 mani87 mani88 mani89 
do
	cat import/manifest/header8089.txt $DPATH/$f_intermed.csv > $OUTPUT_DPATH/$f$header.csv
done

for f in mani90 mani91 mani92 mani93 mani94 mani95 mani96 mani97 mani98 mani99 mani00 mani01 mani02 mani03 mani04 mani05
do
	cat import/manifest/header9005.txt $DPATH/$f_intermed.csv > $OUTPUT_DPATH/$f$header.csv
done

#move 06-16 files to OUTPUT_DPATH (for consistency)
for f in mani06 mani07 mani08 mani9 mani10 mani11 mani12 mani13 mani14 mani15 mani16 
do
	cp $DPATH/$f.csv $OUTPUT_DPATH/$f.csv	

done

# some files have non-UTF8 characters--replace these with asterisks
sed -i 's/\xBA/*/g' $OUTPUT_DPATH/mani88_header.csv
sed -i 's/\xBA/*/g' $OUTPUT_DPATH/mani89_header.csv
sed -i 's/\xE5/*/g' $OUTPUT_DPATH/mani97_header.csv

# create 'manifest. schema
eval $(cat psql_profile.config) 
#psql -c "create schema manifest."


# create tables and populate
for f in man8081 mani82 mani83 mani84 mani85 mani86 mani87 mani88 mani89 
do
	psql -c "DROP TABLE IF EXISTS manifest.$f;"
	psql -c "CREATE TABLE manifest.$f (
		manifest_number VARCHAR(10) NOT NULL, 
		manifest_status VARCHAR(15) NOT NULL, 
		transporter_1_state_id VARCHAR(15) NOT NULL, 
		transporter_2_state_id VARCHAR(15) NOT NULL, 
		generator_shipped_date VARCHAR(6) NOT NULL, 
		transporter_1_received_date VARCHAR(6) NOT NULL, 
		transporter_2_received_date VARCHAR(6) NOT NULL, 
		tsdf_received_date VARCHAR(6) NOT NULL, 
		part_a_received_date VARCHAR(6) NOT NULL, 
		part_b_received_date VARCHAR(6) NOT NULL, 
		generator_rcra_id_number VARCHAR(12) NOT NULL, 
		transporter_1_rcra_id_number VARCHAR(12) NOT NULL, 
		transporter_2_rcra_id_number VARCHAR(12) NOT NULL, 
		tsdf_rcra_id_number VARCHAR(12) NOT NULL, 
		waste_code1 VARCHAR(4) NOT NULL, 
		quantity_of_waste1 VARCHAR(5) NOT NULL, 
		units_of_quantity1 VARCHAR(1) NOT NULL, 
		number_of_containers1 VARCHAR(3) NOT NULL, 
		type_of_container1 VARCHAR(2) NOT NULL, 
		handling_method1 VARCHAR(1) NOT NULL, 
		specific_gravity1 VARCHAR(3) NOT NULL, 
		waste_code2 VARCHAR(4) NOT NULL, 
		quantity_of_waste2 VARCHAR(5) NOT NULL, 
		units_of_quantity2 VARCHAR(1) NOT NULL, 
		number_of_containers2 VARCHAR(3) NOT NULL, 
		type_of_container2 VARCHAR(2) NOT NULL, 
		handling_method2 VARCHAR(1) NOT NULL, 
		specific_gravity2 VARCHAR(3) NOT NULL, 
		waste_code3 VARCHAR(4) NOT NULL, 
		quantity_of_waste3 VARCHAR(5) NOT NULL, 
		units_of_quantity3 VARCHAR(1) NOT NULL, 
		number_of_containers3 VARCHAR(3) NOT NULL, 
		type_of_container3 VARCHAR(2) NOT NULL, 
		handling_method3 VARCHAR(1) NOT NULL, 
		specific_gravity3 VARCHAR(3) NOT NULL, 
		waste_code4 VARCHAR(4) NOT NULL, 
		quantity_of_waste4 VARCHAR(5) NOT NULL, 
		units_of_quantity4 VARCHAR(1) NOT NULL, 
		number_of_containers4 VARCHAR(3) NOT NULL, 
		type_of_container4 VARCHAR(2) NOT NULL, 
		handling_method4 VARCHAR(1) NOT NULL, 
		specific_gravity4 VARCHAR(3) NOT NULL, 
		waste_code5 VARCHAR(4) NOT NULL, 
		quantity_of_waste5 VARCHAR(5) NOT NULL, 
		units_of_quantity5 VARCHAR(1) NOT NULL, 
		number_of_containers5 VARCHAR(3) NOT NULL, 
		type_of_container5 VARCHAR(2) NOT NULL, 
		handling_method5 VARCHAR(1) NOT NULL, 
		specific_gravity5 VARCHAR(3) NOT NULL, 
		waste_code6 VARCHAR(4) NOT NULL, 
		quantity_of_waste6 VARCHAR(5) NOT NULL, 
		units_of_quantity6 VARCHAR(1) NOT NULL, 
		number_of_containers6 VARCHAR(3) NOT NULL, 
		type_of_container6 VARCHAR(2) NOT NULL, 
		handling_method6 VARCHAR(1) NOT NULL, 
		specific_gravity6 VARCHAR(3) NOT NULL 
		);"
	cat $OUTPUT_DPATH/$f$header.csv | psql -c "\copy manifest.$f from stdin with csv header;"
done


for f in mani90 mani91 mani92 mani93 mani94 mani95 mani96 mani97 mani98 mani99 mani00 mani01 mani02 mani03 mani04 mani05
do
        psql -c "DROP TABLE IF EXISTS manifest.$f;"
	psql -c "CREATE TABLE manifest.$f (
		manifest_number VARCHAR(10) NOT NULL, 
		sequence_number VARCHAR(2) NOT NULL, 
		generator_rcra_id_number VARCHAR(12) NOT NULL, 
		generator_shipped_date VARCHAR(10) NOT NULL, 
		tsdf_rcra_id_number VARCHAR(12) NOT NULL, 
		tsdf_received_date VARCHAR(10) NOT NULL, 
		transporter_1_rcra_id_number VARCHAR(12) NOT NULL, 
		transporter_1_state_id VARCHAR(9), 
		transporter_1_received_date VARCHAR(10) NOT NULL, 
		transporter_2_rcra_id_number VARCHAR(12) NOT NULL, 
		transporter_2_state_id VARCHAR(12) NOT NULL, 
		transporter_2_received_date VARCHAR(10) NOT NULL, 
		number_of_containers1 VARCHAR(10) NOT NULL, 
		type_of_container1 VARCHAR(3) NOT NULL, 
		quantity_of_waste1 VARCHAR(5) NOT NULL, 
		units_of_quantity1 VARCHAR(5) NOT NULL, 
		specific_gravity1 VARCHAR(5) NOT NULL, 
		handling_method1 VARCHAR(5) NOT NULL, 
		waste_code1_1 VARCHAR(4) NOT NULL, 
		waste_code1_2 VARCHAR(4) NOT NULL, 
		waste_code1_3 VARCHAR(4) NOT NULL, 
		waste_code1_4 VARCHAR(4) NOT NULL, 
		waste_code1_5 VARCHAR(4) NOT NULL, 
		number_of_containers2 VARCHAR(10) NOT NULL, 
		type_of_container2 VARCHAR(3) NOT NULL, 
		quantity_of_waste2 VARCHAR(5) NOT NULL, 
		units_of_quantity2 VARCHAR(5) NOT NULL, 
		specific_gravity2 VARCHAR(5) NOT NULL, 
		handling_method2 VARCHAR(5) NOT NULL, 
		waste_code2_1 VARCHAR(4) NOT NULL, 
		waste_code2_2 VARCHAR(4) NOT NULL, 
		waste_code2_3 VARCHAR(4) NOT NULL, 
		waste_code2_4 VARCHAR(4) NOT NULL, 
		waste_code2_5 VARCHAR(4) NOT NULL, 
		number_of_containers3 VARCHAR(10) NOT NULL, 
		type_of_container3 VARCHAR(3) NOT NULL, 
		quantity_of_waste3 VARCHAR(5) NOT NULL, 
		units_of_quantity3 VARCHAR(5) NOT NULL, 
		specific_gravity3 VARCHAR(5) NOT NULL, 
		handling_method3 VARCHAR(5) NOT NULL, 
		waste_code3_1 VARCHAR(4) NOT NULL, 
		waste_code3_2 VARCHAR(4) NOT NULL, 
		waste_code3_3 VARCHAR(4) NOT NULL, 
		waste_code3_4 VARCHAR(4) NOT NULL, 
		waste_code3_5 VARCHAR(4) NOT NULL, 
		number_of_containers4 VARCHAR(10) NOT NULL, 
		type_of_container4 VARCHAR(3) NOT NULL, 
		quantity_of_waste4 VARCHAR(5) NOT NULL, 
		units_of_quantity4 VARCHAR(5) NOT NULL, 
		specific_gravity4 VARCHAR(5) NOT NULL, 
		handling_method4 VARCHAR(5) NOT NULL, 
		waste_code4_1 VARCHAR(4) NOT NULL, 
		waste_code4_2 VARCHAR(4) NOT NULL, 
		waste_code4_3 VARCHAR(4) NOT NULL, 
		waste_code4_4 VARCHAR(4) NOT NULL, 
		waste_code4_5 VARCHAR(4) NOT NULL 
		);"
	cat $OUTPUT_DPATH/$f$header.csv | psql -c "\copy manifest.$f from stdin with csv header;"
done

for f in mani06 mani07 mani08 mani9 mani10 mani11 mani12 mani13 mani14 mani15 mani16 
do
	psql -c "DROP TABLE IF EXISTS manifest.$f;"
	psql -c "CREATE TABLE manifest.$f (
		manifest_tracking_num VARCHAR(12) NOT NULL, 
		page_num VARCHAR(6), 
		line_item_num VARCHAR(6), 
		gen_rcra_id VARCHAR(12) NOT NULL, 
		gen_sign_date VARCHAR(20), 
		tsdf_rcra_id VARCHAR(12) NOT NULL, 
		tsdf_sign_date VARCHAR(20), 
		transporter_1_rcra_id VARCHAR(12), 
		transporter_1_sign_date VARCHAR(20), 
		transporter_2_rcra_id VARCHAR(12), 
		transporter_2_sign_date VARCHAR(20), 
		import_ind VARCHAR(1) NOT NULL, 
		export_ind VARCHAR(1) NOT NULL, 
		discr_quantity_ind VARCHAR(1) NOT NULL, 
		discr_type_ind VARCHAR(1) NOT NULL, 
		discr_residue_ind VARCHAR(1) NOT NULL, 
		discr_partial_reject_ind VARCHAR(1) NOT NULL, 
		discr_full_reject_ind VARCHAR(1) NOT NULL, 
		manifest_ref_num VARCHAR(12), 
		alt_facility_rcra_id VARCHAR(12), 
		alt_facility_sign_date VARCHAR(20), 
		num_of_containers VARCHAR(8), 
		container_type_code VARCHAR(4), 
		waste_qty VARCHAR(10), 
		unit_of_measure VARCHAR(4),
		specific_gravity VARCHAR(10), 
		handling_type_code VARCHAR(4), 
		mgmt_method_type_code VARCHAR(4), 
		waste_code_1 VARCHAR(4), 
		waste_code_2 VARCHAR(4), 
		waste_code_3 VARCHAR(4), 
		waste_code_4 VARCHAR(4), 
		waste_code_5 VARCHAR(4), 
		waste_code_6 VARCHAR(4)
		);"
	cat $OUTPUT_DPATH/$f.csv | psql -c "\copy manifest.$f from stdin with csv header;"
done

psql -c "DROP TABLE IF EXISTS manifest.locaddr;"
psql -c "CREATE TABLE manifest.locaddr (
	rcra_id VARCHAR(12) NOT NULL, 
	district_name VARCHAR(76) NOT NULL, 
	location_street1 VARCHAR(69), 
	location_street2 VARCHAR(47), 
	location_city VARCHAR(25), 
	location_state VARCHAR(4), 
	location_zip VARCHAR(5), 
	location_zip_extension VARCHAR(5), 
	location_country VARCHAR(4), 
	location_county VARCHAR(11)
	);"
cat $DPATH/locaddr.csv | psql -c "\copy manifest.locaddr from stdin with csv header;"

# remove the intermediate
rm $DPATH/*clean.txt
# rm $DPATH/*intermed.csv

