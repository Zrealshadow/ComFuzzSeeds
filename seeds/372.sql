select count(*) from pg_proc where proname = 'websearch_to_tsquery';
REINDEX TABLE pg_proc;
