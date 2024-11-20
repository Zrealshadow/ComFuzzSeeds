SELECT query, xact_start, now(),wait_event FROM pg_stat_activity where query like 'CREATE SUBSCRIPTION%';
