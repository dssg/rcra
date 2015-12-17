-- static facility data (as opposed to handler which changes)
DROP TABLE IF EXISTS output.facilities;

CREATE TABLE output.facilities AS (

-- get a comprehensive list of facilities from handler, cmecomp3 and facilities

with active_facilities as (
    select id_number as rcra_id, bool_or(active_site != '-----') as active_today
    from rcra.facilities group by id_number
),

naics as (
    select epa_handler_id as rcra_id, array_agg(distinct naics_code) as naics_codes
    from rcra.hnaics group by epa_handler_id
),

investigations as (
    select rcra_id, min(start_date) as min_start_date, max(start_date) as max_start_date
    from output.investigations
    group by 1
),

handlers as (
    select rcra_id, min(receive_date) as min_receive_date, max(receive_date) as max_receive_date
    from output.handlers group by 1
),

f as (select epa_handler_id as rcra_id from rcra.hhandler UNION select rcra_id from active_facilities UNION select handler_id from rcra.cmecomp3)

select rcra_id,
    coalesce(active_today, False) as active_today,
    state, region,
    naics_codes, min_start_date, max_start_date, min_receive_date, max_receive_date
from f
left join active_facilities using (rcra_id)
left join naics using (rcra_id)
left join investigations using (rcra_id)
left join output.region_states on substring(rcra_id for 2) = state
left join handlers using (rcra_id)
where rcra_id is not null
);

alter table output.facilities add primary key (rcra_id);