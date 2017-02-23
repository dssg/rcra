-- static facility data (as opposed to handler which changes)
DROP TABLE IF EXISTS output.facilities CASCADE;

CREATE TABLE output.facilities AS (

-- get a comprehensive list of facilities from handler, cmecomp3 and facilities

with active as (
    select id_number as rcra_id, bool_or(active_site != '-----') as active_today
    from rcra.facilities group by id_number
),

naics as (
    select epa_handler_id as rcra_id, array_agg(distinct naics_code) as naics_codes
    from rcra.hnaics group by epa_handler_id
),

handler as (
    select epa_handler_id as rcra_id, 
        max(substring(location_zip_code for 5)) as location_zip_code
    from rcra.hhandler group by 1
),

activity as (
    select rcra_id,
        min(date) as min_activity_date,
        max(date) as max_activity_date
    from output.activity
    group by 1
)

select *
from active
full outer join activity using (rcra_id)
left join handler using (rcra_id)
left join naics using (rcra_id)
left join output.region_states on substring(rcra_id for 2) = state
where rcra_id is not null
and ${FACILITIES_CONDITION}
);

alter table output.facilities add primary key (rcra_id);
