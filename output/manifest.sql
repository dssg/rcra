/*Author: Maria Kamenetsky
Date: 22 July 2016
Description: Manifest reduced (reduce to waste_codes) for easier yearly aggregation for Python; observations unit is  
generator RCRAID - year; only look at generators in New York state
*/

drop table if exists output.manifests;
create table output.manifests as(
	select 
	gen_rcra_id as rcra_id,
	gen_sign_date as gen_sign_date,
	array_agg(distinct manifest_tracking_num) as manifest_id,
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
	--sum(waste_qty) as sum_waste,
	array_remove(array_agg(distinct unit_of_measure),null) as measure_unit,
	array_remove(array_agg(distinct handling_type_code),null) as handling_type_code,
	array_remove(array_agg(tsdf_sign_date),null) as tsdf_sign_date,	
	array_remove(array_agg(distinct mgmt_method_type_code),null) as mgmt_method,
        ANYARRAY_UNIQ(ARRAY_REMOVE(ANYARRAY_AGG(
            ARRAY[waste_code_1, waste_code_2, waste_code_3,
                  waste_code_4, waste_code_5, waste_code_6]), NULL)),
	array_remove(array_agg(distinct unit_of_measure),null) as waste_measurement,
	array_remove(array_agg(distinct handling_type_code),null) as handling_code
	from manifest.new_york
	where substring(gen_rcra_id from 1 for 2)='NY'
	group by gen_rcra_id, gen_sign_date
);







