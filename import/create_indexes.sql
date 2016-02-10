drop index if exists cmecomp3_handler_id_evaluation_start_date_idx;
create index cmecomp3_handler_id_evaluation_start_date_idx on rcra.cmecomp3 (handler_id, evaluation_start_date);

drop index if exists hhandler_handler_id_idx;
create index hhandler_handler_id_idx on rcra.hhandler (epa_handler_id);
