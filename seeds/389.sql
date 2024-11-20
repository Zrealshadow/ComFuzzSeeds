select slot_name, restart_lsn, active, active_pid from pg_replication_slots ;
select pg_last_wal_replay_lsn(), pg_last_wal_receive_lsn();
