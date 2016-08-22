
drop table if exists output.manifest;
create table output.manifest as (
select generator_rcra_id_number as rcra_id,
nullif(waste_code_1,'    ')::varchar(5) as waste_code_1,
nullif(waste_code_2,'    ')::varchar(5) as waste_code_2,
nullif(waste_code_3,'    ')::varchar(5) as waste_code_3,
nullif(waste_code_4,'    ')::varchar(5) as waste_code_4,
nullif(waste_code_5,'    ')::varchar(5) as waste_code_5,
waste_code_6::varchar(5),
case when length(num_of_containers)<1 then null
        else nullif(num_of_containers,'   ')::double precision end as num_of_containers,
nullif(unit_of_measure,' ') as unit_of_measure,
case when length(specific_gravity) < 1 then null
        else nullif(specific_gravity,'     ')::double precision  end as specific_gravity,
nullif(handling_type_code,' ')::varchar(5) as handling_type_code,
case when length(waste_qty) < 1 then null
        else nullif(waste_qty,'     ')::double precision end as waste_qty

from

(
with manifest_arrays as (
select generator_rcra_id_number,
        ARRAY[quantity_of_waste1, quantity_of_waste2,quantity_of_waste3, quantity_of_waste4] quantities,
        ARRAY[waste_code1_1, waste_code2_1, waste_code3_1, waste_code4_1]  waste_codes_1,
        ARRAY[waste_code1_2, waste_code2_2, waste_code3_2, waste_code4_2]  waste_codes_2,
        ARRAY[waste_code1_3, waste_code2_3, waste_code3_3, waste_code4_3]  waste_codes_3,
        ARRAY[waste_code1_4, waste_code2_4, waste_code3_4, waste_code4_4]  waste_codes_4,
        ARRAY[waste_code1_5, waste_code2_5, waste_code3_5, waste_code4_5]  waste_codes_5,
        ARRAY[number_of_containers1, number_of_containers2, number_of_containers3, number_of_containers4] num_of_containers,
        ARRAY[units_of_quantity1, units_of_quantity2,units_of_quantity3,units_of_quantity4] as unit_of_measure,
        ARRAY[specific_gravity1,specific_gravity2,specific_gravity3,specific_gravity1] as specific_gravity,
        ARRAY[handling_method1,handling_method2,handling_method3,handling_method4] as handling_type_code
        from raw.mani90_05
)
select generator_rcra_id_number,
unnest(quantities) as waste_qty,
unnest(waste_codes_1) as waste_code_1,
unnest(waste_codes_2) as waste_code_2,
unnest(waste_codes_3) as waste_code_3,
unnest(waste_codes_4) as waste_code_4,
unnest(waste_codes_5) as waste_code_5,
null as waste_code_6,
unnest(num_of_containers) as num_of_containers,
unnest(unit_of_measure) as unit_of_measure,
unnest(specific_gravity) as specific_gravity,
unnest(handling_type_code) as handling_type_code

from manifest_arrays

) as a

union all

select gen_rcra_id as rcra_id,
waste_code_1::varchar(5), waste_code_2::varchar(5), waste_code_3::varchar(5), waste_code_4::varchar(5), waste_code_5::varchar(5), waste_code_6::varchar(5),
case when length(num_of_containers) < 1 then null
        else num_of_containers::double precision end, unit_of_measure::varchar(1),
case when length(specific_gravity) < 1 then null
        else nullif(specific_gravity,'     ')::double precision  end as specific_gravity, handling_type_code::varchar(5),
case when length(waste_qty) < 1 then null
        else nullif(waste_qty,'     ')::double precision end as waste_qty


from manifest.mani06_
);




-- Converting waste_qty to all be in pounds
ALTER TABLE output.manifest add approx_qty double precision;



do $$
DECLARE POUNDS_IN_ONE_GALLON_OF_WATER  double precision := 8.345404;
DECLARE POUNDS_IN_KILO  double precision := 2.20462;
DECLARE POUNDS_IN_GRAM  double precision := 0.00220462;
DECLARE POUNDS_IN_TON  double precision := 2000;
DECLARE POUNDS_IN_METRIC_TON  double precision := 2204.62;

DECLARE GALLONS_IN_CUBIC_METER  double precision := 264.172;
DECLARE GALLONS_IN_LITER  double precision := 0.264172;
DECLARE GALLONS_IN_CUBIC_YARD  double precision := 201.974;
BEGIN
update output.manifest
set approx_qty = case when unit_of_measure = 'K' then waste_qty * POUNDS_IN_KILO
                when unit_of_measure = 'P' then waste_qty
                when unit_of_measure = 'G' then waste_qty * POUNDS_IN_GRAM
                when unit_of_measure = 'L' then specific_gravity * POUNDS_IN_ONE_GALLON_OF_WATER * waste_qty * GALLONS_IN_LITER
                when unit_of_measure = 'M' then waste_qty * POUNDS_IN_METRIC_TON
                when unit_of_measure = 'N' then specific_gravity * POUNDS_IN_ONE_GALLON_OF_WATER * waste_qty * GALLONS_IN_CUBIC_METER
                when unit_of_measure = 'T' then waste_qty * POUNDS_IN_TON
                when unit_of_measure = 'Y' then specific_gravity * POUNDS_IN_ONE_GALLON_OF_WATER * waste_qty * GALLONS_IN_CUBIC_YARD
                end;
end $$;







