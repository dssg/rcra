/* 
Authors: Paul van der Boor, Maria Kamenetsky
Purpose: To create view of spatial data to be able to work with it in PostGIS and visualize it in QGIS
Date: 4/5 August 2016
*/


--Create view that is the intersection of New York state and its zip codes; we include those zip codes that are touching the state boundary
CREATE SCHEMA IF NOT EXISTS geo;


DROP VIEW IF EXISTS geo.NY_zipcodes;

CREATE VIEW geo.NY_zipcodes AS (
    SELECT zipcode.* FROM
    geo.zipcode JOIN
        geo.states ON ST_INTERSECTS(zipcode.geom, states.geom)
    WHERE name = 'New York');


DROP VIEW geo.floodhaz;

CREATE VIEW geo.floodhaz AS (
	SELECT 

