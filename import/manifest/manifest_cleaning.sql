/*
Author: Dean Magee
Purpose: To combine the required manifest tables and set data types so that they can be analysed easily
Date: 9th June 2016
*/

-- Manifest data for years 1980 to 1989

/* Commenting out the earlier MANIFEST data because it is not currently being used 
DROP TABLE IF EXISTS manifest.mani80_89;
create table manifest.mani80_89 as 
	select * from (
		select * from manifest.man8081
		union all
		select * from manifest.mani82
		union all
		select * from manifest.mani83
		union all
		select * from manifest.mani84
		union all
		select * from manifest.mani85
		union all
		select * from manifest.mani86
		union all
		select * from manifest.mani87
		union all
		select * from manifest.mani88
		union all
		select * from manifest.mani89
	) as a;
*/

-- Manifest data for years 1990 to 2005
DROP TABLE IF EXISTS manifest.mani90_05;
create table manifest.mani90_05 as 
	select * from (
		select * from manifest.mani90
		union all
		select * from manifest.mani91
		union all
		select * from manifest.mani92
		union all
		select * from manifest.mani93
		union all 
		select * from manifest.mani94
		union all
		select * from manifest.mani95
		union all
		select * from manifest.mani96
		union all 
		select * from manifest.mani97
		union all
		select * from manifest.mani98
		union all
		select * from manifest.mani99
		union all 
		select * from manifest.mani00
		union all
		select * from manifest.mani01
		union all
		select * from manifest.mani02
		union all
		select * from manifest.mani03
		union all
		select * from manifest.mani04
		union all
		select * from manifest.mani05
	) as a;


--Manifest data 2006 to 2016
DROP TABLE IF EXISTS manifest.mani06_;
create table manifest.mani06_ as
	select * from  (
		select * from manifest.mani06
		union all
		select * from manifest.mani07
		union all
		select * from manifest.mani08
		union all
		select * from manifest.mani9
		union all
		select * from manifest.mani10
		union all
		select * from manifest.mani11
		union all
		select * from manifest.mani12
		union all
		select * from manifest.mani13
		union all
		select * from manifest.mani14
		union all
		select * from manifest.mani15
		union all
		select * from manifest.mani16
	) as a;



-- Fixing the date column types for the manifest data 2006 to 2016
 
ALTER TABLE manifest.mani06_ ALTER COLUMN gen_sign_date TYPE DATE using gen_sign_date::date;
ALTER TABLE manifest.mani06_ ALTER COLUMN tsdf_sign_date TYPE DATE using tsdf_sign_date::date;
ALTER TABLE manifest.mani06_ ALTER COLUMN transporter_1_sign_date TYPE DATE using case when length(transporter_1_sign_date) < 4 
																		then null 
																		else transporter_1_sign_date::date 
																		end ;
ALTER TABLE manifest.mani06_ ALTER COLUMN transporter_2_sign_date TYPE DATE using case when length(transporter_2_sign_date) < 4 
																					then null
	
	  else transporter_2_sign_date::date																				
	  end ; 



---Fixing up the 1990 - 2005 manifest data
ALTER TABLE manifest.mani90_05 ALTER COLUMN generator_shipped_date TYPE DATE using generator_shipped_date::date;
ALTER TABLE manifest.mani90_05 ALTER COLUMN tsdf_received_date TYPE DATE using tsdf_received_date::date;

