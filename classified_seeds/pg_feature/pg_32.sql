SELECT pid, state, age(query_start, clock_timestamp()), usename, query FROM pg_stat_activity WHERE query != '<IDLE>' AND state != 'idle' ORDER BY age limit 100;
