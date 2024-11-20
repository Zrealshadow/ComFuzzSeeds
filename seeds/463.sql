SELECT pid, state, now() - backend_start AS backend_age, now() - xact_start AS xact_age, now() - state_change AS state_age, query 
FROM pg_stat_activity 
WHERE state = 'idle in transaction' 
ORDER BY backend_start;
