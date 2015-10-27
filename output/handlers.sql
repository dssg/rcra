drop table if exists output.handlers;

create table output.handlers as (

select 
    epa_handler_id as rcra_id, receive_date, 
    non_notifier = 'X' as non_notifier,
    non_notifier = 'O' as non_notifier_former,
    non_notifier = 'E' as non_notifier_exempt,

    location_zip_code,
    mailing_zip_code,
    
    land_type =

from rcra.hhandler
);
