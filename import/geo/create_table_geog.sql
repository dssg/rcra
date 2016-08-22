/* 
Authors: Paul van der Boor, Maria Kamenetsky
Purpose: To create view of spatial data to be able to work with it in PostGIS and visualize it in QGIS
Date: 4/5 August 2016
*/


--Create view that is the intersection of New York state and its zip codes; we include those zip codes that are touching the state boundary

--Create the geography schema
CREATE SCHEMA IF NOT EXISTS geo;


--View to load the zip codes in NY only
DROP VIEW IF EXISTS geo.NY_zipcodes;

CREATE VIEW geo.NY_zipcodes AS (
    SELECT zipcode.* FROM
    geo.zipcode JOIN
        geo.states ON ST_INTERSECTS(zipcode.geom, states.geom)
    WHERE name = 'New York');



DROP VIEW geo.NY_zipcodes;

CREATE VIEW geo.NY_zipcodes AS
    select * from
    geo.zipcode as zip
    where ST_TOUCHES(zip.geom,
	                     (
				    SELECT geom from geo.ny_zipcode
				    where name = 'New York')
			    );	

--view to get the flood haz in NY zip codes only

drop table geo.flood_ny_ar_table if exists;
create table geo.flood_ny_ar_table as
        select distinct nyz.geom, nyz.gid from geo.floodhaz_ar fld inner join
	                        geo.ny_zipcodes nyz on ST_Intersects(fld.geom, nyz.geom);


--create table of lat/lon
drop table if exists geo.new_york_lat_long;
create table geo.new_york_lat_long as(
	select h.rcra_id as gid, st_setsrid(st_makepoint(l.longitude_measure,l.latitude_measure), 4326) as geom
	from output.facilities h left join rcra.gis_lat_long l on (h.rcra_id = l.handler_id)
	where h.state = 'NY'
)




