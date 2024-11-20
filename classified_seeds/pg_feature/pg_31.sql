SELECT
    datname,
    pid,
    query,
    usename,
    client_addr,
    client_port,
    state,
    backend_xid,
    EXTRACT(MINUTE FROM (current_timestamp - state_change)) as duration 
FROM pg_stat_activity
WHERE
    datname = 'postgres'
    AND pid <> pg_backend_pid()
    AND state = 'idle'
ORDER BY
    backend_start DESC;

select name, setting
from pg_settings
where
    name = 'idle_session_timeout'
    OR name = 'idle_in_transaction_session_timeout';
