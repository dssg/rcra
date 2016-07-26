/*Author: Maria Kamenetsky
Date: 11 July 2016
Description: Manifest reduced (reduce to waste_codes) for easier yearly aggregation for Python; observations unit is  
generator RCRAID - year; only look at generators in New York state
*/

drop table if exists summary.manifests_year;
create table summary.manifests_year as(
	select 
	substring(gen_rcra_id from 1 for 2) as state,
	extract(year from gen_sign_date)::varchar(4) as year,
	array_agg(distinct manifest_tracking_num) as manifest_id,
	gen_rcra_id as rcra_id,
	array_remove(array_agg(gen_sign_date),null) as gen_sign_date,
	array_remove(array_agg(distinct tsdf_rcra_id),null) as tsdf_id,
	array_remove(array_agg(distinct transporter_1_rcra_id),null) as transporter1_id,
	array_remove(array_agg(distinct transporter_2_rcra_id),null) as transporter2_id,
	bool_or(import_ind = 'Y') as import,
	bool_or(export_ind = 'Y') as export,
	bool_or(discr_quantity_ind = 'Y') as discr_quantity,
	bool_or(discr_type_ind = 'Y') as discr_type_ind,
	bool_or(discr_residue_ind = 'Y') as discr_residue,
	bool_or(discr_partial_reject_ind='Y') as discr_partial_reject_ind,
	bool_or(discr_partial_reject_ind='Y') as discr_full_reject_ind,
	sum(num_of_containers) as num_containers,
	sum(waste_qty) as sum_waste,
	array_remove(array_agg(distinct unit_of_measure),null) as measure_unit,
	array_remove(array_agg(distinct handling_type_code),null) as handling_type_code,
	array_remove(array_agg(tsdf_sign_date),null) as tsdf_sign_date,
	array_remove(array_agg(distinct mgmt_method_type_code),null) as mgmt_method,
	array_remove(array_agg(distinct coalesce(waste_code_1,'')|| ';' || coalesce(waste_code_2,'') || ';' ||  coalesce(waste_code_3,'') ||';' || coalesce(waste_code_4,'') ||';' ||  coalesce(waste_code_5,'') ||';' ||  coalesce(waste_code_6,'')), null) as waste_codes,
	array_remove(array_agg(distinct unit_of_measure),null) as waste_measurement,
	array_remove(array_agg(distinct handling_type_code),null) as handling_code
	from manifest.new_york
	where substring(gen_rcra_id from 1 for 2)='NY'
	group by gen_rcra_id, extract(year from gen_sign_date)::varchar(4)
);


drop table if exists output.manifests;
create table output.manifests as(
	select 
	substring(gen_rcra_id from 1 for 2) as state,
	array_agg(extract(year from gen_sign_date)::varchar(4)) as year,
	max(greatest({dates})) as max_date,
	array_agg(distinct manifest_tracking_num) as manifest_id,
	gen_rcra_id as rcra_id,
	gen_sign_date as gen_sign_date,
	array_remove(array_agg(distinct tsdf_rcra_id),null) as tsdf_id,
	array_remove(array_agg(distinct transporter_1_rcra_id),null) as transporter1_id,
	array_remove(array_agg(distinct transporter_2_rcra_id),null) as transporter2_id,
	bool_or(import_ind = 'Y') as import,
	bool_or(export_ind = 'Y') as export,
	bool_or(discr_quantity_ind = 'Y') as discr_quantity,
	bool_or(discr_type_ind = 'Y') as discr_type_ind,
	bool_or(discr_residue_ind = 'Y') as discr_residue,
	bool_or(discr_partial_reject_ind='Y') as discr_partial_reject_ind,
	bool_or(discr_partial_reject_ind='Y') as discr_full_reject_ind,
	sum(num_of_containers) as num_containers,
	sum(waste_qty) as sum_waste,
	array_remove(array_agg(distinct unit_of_measure),null) as measure_unit,
	array_remove(array_agg(distinct handling_type_code),null) as handling_type_code,
	array_remove(array_agg(tsdf_sign_date),null) as tsdf_sign_date,	
	array_remove(array_agg(distinct mgmt_method_type_code),null) as mgmt_method,
	array_remove(array_agg(distinct coalesce(waste_code_1,'')|| ';' || coalesce(waste_code_2,'') || ';' ||  coalesce(waste_code_3,'') ||';' || coalesce(waste_code_4,'') ||';' ||  coalesce(waste_code_5,'') ||';' ||  coalesce(waste_code_6,'')), null) as waste_codes,
	array_remove(array_agg(distinct unit_of_measure),null) as waste_measurement,
	array_remove(array_agg(distinct handling_type_code),null) as handling_code
	from manifest.new_york
	where substring(gen_rcra_id from 1 for 2)='NY'
	group by gen_rcra_id, gen_sign_date
);







