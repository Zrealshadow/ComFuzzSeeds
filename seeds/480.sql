SELECT relname, relkind FROM pg_class WHERE pg_relation_filepath(oid) ~ '16393/12769';
