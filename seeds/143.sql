select p.datname,pg_database_size(p.datname) from pg_database p
