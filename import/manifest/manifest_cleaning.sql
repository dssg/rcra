/*
Author: Dean Magee
Purpose: To combine the required manifest tables and set data types so that they can be analysed easily
Date: 9th June 2016
*/

-- Manifest data for years 1980 to 1989

/* Commenting out the earlier MANIFEST data because it is not currently being used 
DROP TABLE IF EXISTS raw.mani80_89;
create table raw.mani80_89 as 
	select * from (
		select * from raw.man8081
		union
		select * from raw.mani82
		union
		select * from raw.mani83
		union
		select * from raw.mani84
		union
		select * from raw.mani85
		union
		select * from raw.mani86
		union
		select * from raw.mani87
		union
		select * from raw.mani88
		union
		select * from raw.mani89
	) as a;


-- Manifest data for years 1990 to 2005
DROP TABLE IF EXISTS raw.mani90_05;
create table raw.mani90_05 as 
	select * from (
		select * from raw.mani90
		union
		select * from raw.mani91
		union
		select * from raw.mani92
		union
		select * from raw.mani93
		union 
		select * from raw.mani94
		union
		select * from raw.mani95
		union
		select * from raw.mani96
		union 
		select * from raw.mani97
		union
		select * from raw.mani98
		union
		select * from raw.mani99
		union 
		select * from raw.mani00
		union
		select * from raw.mani01
		union
		select * from raw.mani02
		union
		select * from raw.mani03
		union
		select * from raw.mani04
		union
		select * from raw.mani05
	) as a;

*/
--Manifest data 2006 to 2016
DROP TABLE IF EXISTS manifest.new_york;
create table manifest.new_york as
	select * from  (
		select * from raw.mani06
		union
		select * from raw.mani07
		union
		select * from raw.mani08
		union
		select * from raw.mani9
		union
		select * from raw.mani10
		union
		select * from raw.mani11
		union
		select * from raw.mani12
		union
		select * from raw.mani13
		union
		select * from raw.mani14
		union
		select * from raw.mani15
		union
		select * from raw.mani16
	) as a;



-- Fixing the date column types for the manifest data 2006 to 2016
 
ALTER TABLE manifest.new_york ALTER COLUMN gen_sign_date TYPE DATE using gen_sign_date::date;
ALTER TABLE manifest.new_york ALTER COLUMN tsdf_sign_date TYPE DATE using tsdf_sign_date::date;
ALTER TABLE manifest.new_york ALTER COLUMN transporter_1_sign_date TYPE DATE using case when length(transporter_1_sign_date) < 4 
																		then null 
																		else transporter_1_sign_date::date 
																		end ;
ALTER TABLE manifest.new_york ALTER COLUMN transporter_2_sign_date TYPE DATE using case when length(transporter_2_sign_date) < 4 
																					then null
	
	  else transporter_2_sign_date::date																				
	  end ; 


-- Converting waste_qty to all be in pounds
ALTER TABLE manifest.new_york add approx_qty double precision;

ALTER TABLE manifest.new_york 
    ALTER column waste_qty type double precision using 
    case when length(waste_qty) >0 then waste_qty::double precision
    else null
    end;

ALTER TABLE manifest.new_york 
    ALTER column specific_gravity type double precision using 
    case when length(specific_gravity) > 0 then specific_gravity::double precision
    else null
    end;

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
        update manifest.new_york 
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

/* Commenting out earlier manifest data
---Fixing up the 1990 - 2005 manifest data
ALTER TABLE raw.mani90_05 ALTER COLUMN generator_shipped_date TYPE DATE using generator_shipped_date::date;
ALTER TABLE raw.mani90_05 ALTER COLUMN tsdf_received_date TYPE DATE using tsdf_received_date::date;
*/
