select trim ('nextval(''' from
substring('nextval(''database_table_id_seq''::regclass)' from
'%#"%_id_seq#"%' for '#' ));
select trim ('nextval(''' from
substring('nextval(''auth_table_id_seq''::regclass)' from '%#"%_id_seq#"%'
for '#' ));
