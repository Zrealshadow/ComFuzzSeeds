select ssl from pg_stat_ssl where pid=pg_backend_pid();
select pid,usename,application_name,query_start,xact_start,state_change,wait_event_type,state,query from pg_stat_activity where pid=1245344;
