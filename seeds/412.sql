SELECT '0/16952DE0' <= replay_lsn AND state = 'streaming'
FROM pg_catalog.pg_stat_replication
WHERE application_name IN ('standby_1', 'walreceiver')
