---
--- All entries must have RCRA ID and evaluation start date (make unique ID)
--- Do not consider four types of (follow-up) inspections 
--- agency_epa column for evaluating performance on EPA vs state evaluations
---

drop table if exists output.inspections;

create table output.inspections as
select handler_id as id_number, evaluation_start_date, 
evaluation_start_date as feature_gen_date, state as state_code,
max(found_violation_flag) as label, count(*) as num_of_inspections,
count(case when found_violation_flag = 'Y' then 1 else null end) as num_of_violations_found,
max(case when evaluation_agency in ('E','X','C','N') then 1 else 0 end) as agency_epa,
max(case when cast(enforcement_type as int) > 300
          and cast(enforcement_type as int) < 800 then 1 else 0 end) as label_enforcement 
from rcra.cmecomp3 
where handler_id is not null 
and evaluation_start_date is not null
and evaluation_type not in ('FUI','SNN','SNY','FSD')
and (violation_determined_date is null or evaluation_start_date <= violation_determined_date)
group by 1,2,3,4;

-- Add unique ID for RCRA ID & evaluation start date pairs
ALTER TABLE output.inspections ADD COLUMN unique_id SERIAL PRIMARY KEY;
