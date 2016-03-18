create table regions.region_five as (

    with universe as (
        select rcra_id from output.br
        join output.facilities using (rcra_id)
        where region=5 and reporting_year=2013 and
            (not max_start_date between '2013-01-01' and '2015-12-31' or max_start_date is null)
    )

    select rcra_id,
        eligible, inspection,
        universe.rcra_id is not null as universe,
        core_lqg.rcra_id is not null as core,
        region_five_swaps.rcra_id is not null as substitute
    From universe full outer join regions.region_five_all using (rcra_id)
    full outer join regions.core_lqg using (rcra_id)
    full outer join regions.region_five_swaps using (rcra_id)
);
