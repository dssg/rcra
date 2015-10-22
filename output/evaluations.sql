---
--- All entries must have RCRA ID and evaluation start date (make unique ID)
--- Do not consider four types of (follow-up) inspections 
--- agency_epa column for evaluating performance on EPA vs state evaluations
---

drop table if exists output.evaluations;

create table output.evaluations as
select handler_id as rcra_id, evaluation_start_date start_date, state,
    bool_or(found_violation_flag = 'Y') as violation,
    count(*) as inspection_count,
    count(case when found_violation_flag = 'Y' then 1 else null end) as violation_count,
    bool_or(evaluation_agency in ('E','X','C','N')) as agency_epa,
    coalesce(bool_or(enforcement_type::int between 300 and 799), false) formal_enforcement

from rcra.cmecomp3 
   where handler_id is not null 
   and evaluation_start_date is not null
   and evaluation_type not in ('FUI','SNN','SNY','FSD')
   and (violation_determined_date is null or evaluation_start_date <= violation_determined_date)
group by 1,2,3;

ALTER TABLE output.evaluations ADD UNIQUE (rcra_id, start_date);

-- Add unique ID for RCRA ID & evaluation start date pairs
ALTER TABLE output.evaluations ADD COLUMN evaluation_id SERIAL PRIMARY KEY;
