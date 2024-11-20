SELECT pg_terminate_backend(pid) FROM pg_stat_replication WHERE state = 'backup';
