-- static facility data (as opposed to handler which changes)
DROP TABLE IF EXISTS output.facilities;

CREATE TABLE output.facilities AS (

-- get a comprehensive list of facilities from handler, cmecomp3 and facilities
with f as (select epa_handler_id as rcra_id from rcra.hhandler UNION select id_number from rcra.facilities UNION select handler_id from rcra.cmecomp3)

select rcra_id,
    substring(rcra_id for 2) as state,
    region,
    active_site != '-----' as active_today,
    naics_code
from f
left join rcra.facilities on rcra_id = id_number
left join rcra.hnaics on rcra_id = epa_handler_id
left join output.region_states on substring(rcra_id for 2) = state
);

alter table output.facilities add primary key (rcra_id);
