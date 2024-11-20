SELECT slot_name, pg_current_wal_lsn(), confirmed_flush_lsn,
(pg_current_wal_lsn() - confirmed_flush_lsn) AS lag 
FROM pg_replication_slots;

SELECT usename, client_addr, pg_current_wal_lsn(), flush_lsn,
(pg_current_wal_lsn() - flush_lsn) AS lag 
FROM pg_stat_replication;
