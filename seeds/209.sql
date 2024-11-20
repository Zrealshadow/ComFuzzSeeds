select count(*) AS server_connections from pg_stat_activity where backend_type = 'client backend';
select count(*) AS locks_waiting from pg_stat_activity where backend_type = 'client backend' and wait_event_type like '%Lock%';
