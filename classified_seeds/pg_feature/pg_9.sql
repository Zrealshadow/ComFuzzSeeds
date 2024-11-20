select schemaname,relname,n_live_tup,n_dead_tup,n_mod_since_analyze from pg_stat_all_tables where relname in ('pg_attribute','pg_class','pg_index');
select pg_size_pretty(pg_total_relation_size('pg_attribute'));
SHOW ignore_system_indexes;
SET log_parser_stats = true;
SET log_planner_stats = true;
SET client_min_messages = log;
