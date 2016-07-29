drop index if exists rcra.cmecomp3_handler_id_evaluation_start_date_idx;
create index cmecomp3_handler_id_evaluation_start_date_idx on rcra.cmecomp3 (handler_id, evaluation_start_date);

drop index if exists rcra.hhandler_epa_handler_id_idx;
create index hhandler_epa_handler_id_idx on rcra.hhandler (epa_handler_id);
