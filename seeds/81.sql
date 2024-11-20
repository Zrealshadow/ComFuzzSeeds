SELECT pg_blocking_pids(pg_backend_pid()),
array_length(pg_blocking_pids(pg_backend_pid()), 1), '{}'::integer[],
array_length('{}'::integer[], 1);
