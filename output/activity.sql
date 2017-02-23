drop table if exists output.activity;

create table output.activity as (
    select 'C' as type, handler_id as rcra_id, evaluation_start_date as date
    from rcra.cmecomp3
    group by 2,3
    UNION ALL
    select 'H', epa_handler_id, receive_date
    from rcra.hhandler
    group by 2,3
    UNION ALL
    select 'M', gen_rcra_id, gen_sign_date
    from manifest.mani06_
    group by 2,3
    UNION ALL
    select 'M', generator_rcra_id_number, generator_shipped_date
    from manifest.mani90_05
    group by 2,3
    UNION ALL
    select 'B', handler_id, make_date(report_cycle::int+1, 3, 1)
    from rcra.br_reporting
    group by 2,3
);

create index on output.activity (rcra_id, date);
