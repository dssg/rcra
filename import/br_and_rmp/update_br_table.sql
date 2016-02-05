
--------------------------------
---change report cycle into date 
--------------------------------

-- First, add new column with date format
alter table br_and_rmp.brs_all add column date_year date; 

-- convert dates column into date format and put in date_format column
update br_and_rmp.brs_all
set date_year = to_date("report_cycle", 'YYYY-MM');

----------------------------------------------
-- first convert waste numbers into floats to later sum
---------------------------------------------- 
alter table br_and_rmp.brs_all add column gen_tons real;
alter table br_and_rmp.brs_all alter column gen_tons type float using "generation_tons"::float;
alter table br_and_rmp.brs_all add column man_tons real;
alter table br_and_rmp.brs_all alter column man_tons type float using "managed_tons"::float;
alter table br_and_rmp.brs_all add column ship_tons real;
alter table br_and_rmp.brs_all alter column ship_tons type float using "shipped_tons"::float;
alter table br_and_rmp.brs_all add column rec_tons real;
alter table br_and_rmp.brs_all alter column rec_tons type float using "received_tons"::float;

-------------------------------------
--- Waste shipped but not generated or managed 
-------------------------------------
alter table br_and_rmp.brs_all add column ship_not_man_or_gen int;

update br_and_rmp.brs_all
       set rec_not_man_or_gen = case when (ship_tons > 0 and man_tons = 0) and
       (ship_tons > 0 and gen_tons = 0) then 1 else 0 end;

------------------------------------
-- Waste receieved by not generated or managed
------------------------------------
alter table br_and_rmp.brs_all add column rec_not_man_or_gen int;	


update br_and_rmp.brs_all
       set rec_not_man_or_gen = case when (rec_tons > 0 and man_tons = 0) and
       (rec_tons > 0 and gen_tons = 0) then 1 else 0 end;
