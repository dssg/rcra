---
--- All entries must have RCRA ID and evaluation start date (make unique ID)
--- Do not consider four types of (follow-up) inspections 
--- agency_epa column for evaluating performance on EPA vs state evaluations
---

drop table if exists output.investigations;

create table output.investigations as
select
    handler_id as rcra_id,
    evaluation_start_date as start_date,

    bool_or(violation_type is not null)  as violation,
    min(violation_determined_date) as violation_date,

    bool_or(coalesce(enforcement_type::int between 300 and 799, false)) as formal_enforcement,
    min(enforcement_action_date) as formal_enforcement_date,

    bool_or(evaluation_agency in ('E','X','C','N')) as agency_epa

from rcra.cmecomp3 
   where handler_id is not null 
   and evaluation_start_date is not null
   and evaluation_type not in ('FUI','SNN','SNY','FSD')

group by handler_id, evaluation_start_date;
