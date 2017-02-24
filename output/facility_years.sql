-- summarize investigations into years
-- important columns from output.investigations

create temp table investigation_years as (
select rcra_id,
        date_floor(start_date, ${MONTH}, ${DAY}) as date,
        true as evaluation,
        coalesce(bool_or(agency_epa), False) as evaluation_epa,
        coalesce(bool_or(not agency_epa), False) as evaluation_state,

        bool_or(CASE WHEN agency_epa THEN violation ELSE null END) as violation_epa, -- was there a vio
        bool_or(CASE WHEN agency_epa THEN null ELSE violation END) as violation_state, -- was there a v
        bool_or(violation) as violation,

        bool_or(CASE WHEN agency_epa THEN enforcement ELSE null END) as enforcement_epa,
        bool_or(CASE WHEN agency_epa THEN null ELSE enforcement END) as enforcement_state,
        bool_or(enforcement) as enforcement,

        bool_or(CASE WHEN agency_epa THEN formal_enforcement ELSE null END) as formal_enforcement_epa,
        bool_or(CASE WHEN agency_epa THEN null ELSE formal_enforcement END) as formal_enforcement_state,
        bool_or(formal_enforcement) as formal_enforcement,

        anyarray_uniq(anyarray_agg(CASE WHEN agency_epa THEN violation_types ELSE ARRAY[]::varchar[] END)) as violation_types_epa,
        anyarray_uniq(anyarray_agg(CASE WHEN agency_epa THEN ARRAY[]::varchar[] ELSE violation_types END)) as violation_types_state,
        anyarray_uniq(anyarray_agg(violation_types)) as violation_types

from output.investigations i
where start_date >= '${MIN_YEAR}-${MONTH}-${DAY}' and start_date <= '${MAX_YEAR}-${MONTH}-${DAY}'
    and (min_violation_determined_date >= start_date or not violation)
group by 1,2
);

create unique index on investigation_years (rcra_id, date);

create temp table uninvestigated_years as (
    select f.rcra_id, make_date(year, ${MONTH}, ${DAY}) as date
    from output.facilities f
    join generate_series(${MIN_YEAR}, ${MAX_YEAR}) as year on 1=1
    left join investigation_years i on f.rcra_id = i.rcra_id and i.date = make_date(year, ${MONTH}, ${DAY})
    where i.rcra_id is null 
);

create unique index on uninvestigated_years (rcra_id, date);

create temp table uninvestigated_activity as (
    select f.rcra_id, f.date
    from uninvestigated_years f
    join output.activity a on a.rcra_id = f.rcra_id and a.date < f.date
    where ${ACTIVE_CONDITION}
    group by 1,2
);

-- this table has a row for every facility year if:
-- 1) facility's handler has been received
-- 2) facility was not investigated that year
create temp table active_not_investigated as (
    select rcra_id, date,
        false as evaluation, false as evaluation_epa, false as evaluation_state,
        null::bool violation, null::bool violation_epa, null::bool violation_state,
        null::bool enforcement, null::bool enforcement_epa, null::bool enforcement_state,
        null::bool formal_enforcement, null::bool formal_enforcement_epa, null::bool formal_enforcement_statea,
        ARRAY[]::varchar[] violation_types_epa, ARRAY[]::varchar[] violation_types_state, ARRAY[]::varchar[] violation_types
    from uninvestigated_activity
);

-- facility years is union of investigated and uninvestigated
create temp table facility_years as (
    select * from investigation_years i
    UNION ALL
    select * from active_not_investigated
);

create unique index on facility_years (rcra_id, date);

-- handler_id is the id of the handler form in output.handlers
-- this step finds for each facility_year the most recent handler form's id
ALTER TABLE facility_years add column handler_id int;

UPDATE facility_years fy
SET handler_id = h.handler_id
FROM
    (select distinct on(i.rcra_id, i.date) i.rcra_id, i.date, h.handler_id
    from facility_years i
    join output.handlers h
    on h.rcra_id = i.rcra_id and i.date > h.receive_date
    order by i.rcra_id, i.date, receive_date desc) as h
WHERE
    h.rcra_id = fy.rcra_id and h.date = fy.date;


-- join up to create the final facility years table
drop table if exists output.facility_years${MONTH}${DAY};
create table output.facility_years${MONTH}${DAY} as (
    select * from facility_years f 
);

create index on output.facility_years${MONTH}${DAY} (date);
