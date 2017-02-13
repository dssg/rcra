drop table if exists output.handler_names;

create table output.handler_names as (
    select distinct on (rcra_id) rcra_id,
        regexp_replace(regexp_replace(regexp_replace(current_site_name, 
                '[^ A-Z0-9]', ' ', 'g'),
                '\s{2,}', ' ', 'g'), 
                ' [0-9]+', '', 'g') cleaned_site_name
    from output.handlers
    order by rcra_id, receive_date asc
);

alter table output.handler_names add primary key (rcra_id);
