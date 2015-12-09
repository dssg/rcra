drop table if exists output.facility_years{table_suffix};

create table output.facility_years{table_suffix} as (
with investigations as (
select rcra_id,
       ((extract(year from start_date)::text || '{doy}')::date - ((extract(year from start_date)::text || '{doy}')::date > start_date)::int * interval '1 year')::date as date,
        true as evaluation,
        coalesce(bool_or(agency_epa), False) as evaluation_epa,
        coalesce(bool_or(not agency_epa), False) as evaluation_state,

        bool_or(CASE WHEN agency_epa THEN violation ELSE null END) as violation_epa, -- was there a violation in an epa inspection? null if no epa inspections
        bool_or(CASE WHEN agency_epa THEN null ELSE violation END) as violation_state, -- was there a violation in state inspection? null if no state inspections
        bool_or(violation) as violation,

        bool_or(CASE WHEN agency_epa THEN formal_enforcement ELSE null END) as formal_enforcement_epa,
        bool_or(CASE WHEN agency_epa THEN null ELSE formal_enforcement END) as formal_enforcement_state,
        bool_or(formal_enforcement) as formal_enforcement,

        min(CASE WHEN agency_epa THEN formal_enforcement_date ELSE null END) as min_formal_enforcement_date_epa,
        min(CASE WHEN agency_epa THEN null ELSE formal_enforcement_date END) as min_formal_enforcement_date_state,
        min(formal_enforcement_date) as min_formal_enforcement_date
        
from output.investigations
        where start_date between '{min_year}{doy}' and '{max_year}{doy}'
        group by 1,2
),

active as (
    select rcra_id, (year::text || '{doy}')::date
    from output.facilities
    join generate_series({min_year}, {max_year}) as year on 1=1
    where min_receive_date <  (year::text || '{doy}')::date -- handler received
),

active_not_investigated as (
    select a.rcra_id, a.date, false as evaluation, false as evaluation_epa, false as evaluation_state,
        null::bool, null::bool, null::bool,
        null::bool, null::bool, null::bool,
        null::date, null::date, null::date
    from active a left join investigations i using (rcra_id, date)
    where i.rcra_id is null
),

facility_years as (
    select * from investigations
    UNION ALL
    select * from active_not_investigated
),

future as (
    select i1.rcra_id, i1.date,
        bool_or(CASE WHEN i2.agency_epa THEN i2.violation ELSE null END) as violation_future_epa,
        bool_or(CASE WHEN i2.agency_epa THEN null ELSE i2.violation END) as violation_future_state,
        bool_or(i2.violation) as violation_future
    from facility_years i1 join output.investigations i2
        on i1.rcra_id = i2.rcra_id and i1.date <= i2.start_date
    group by 1,2
),

handler_ids as (
    select distinct on(i.rcra_id, i.date) i.rcra_id, i.date, h.handler_id
    from facility_years i
    join output.handlers h
    on h.rcra_id = i.rcra_id and i.date > h.receive_date
    order by i.rcra_id, i.date, receive_date desc
)

select *,
    h.rcra_id is not null as handler_received,
    date - receive_date as handler_age

from facility_years i
left join future using (rcra_id, date)
left join output.facilities using (rcra_id)
left join handler_ids using (rcra_id, date)
left join output.handlers h using (rcra_id, handler_id)
-- evaluated or (handler received and (active or handler received within past year)
where evaluation or (h.rcra_id is not null 
    and (active_today or (date::timestamp - h.receive_date::timestamp) <= interval '2 years')) 
);

create index on output.facility_years{table_suffix} (date);
