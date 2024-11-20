BEGIN;
SET LOCAL stats_fetch_consistency = cache;
SELECT * FROM pg_stat_database;
SET LOCAL stats_fetch_consistency = snapshot;
SELECT pg_stat_get_function_calls(0);
