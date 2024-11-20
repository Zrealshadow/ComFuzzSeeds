SELECT pg_cancel_backend(16647);
SELECT pg_terminate_backend(16647);
select pid,application_name FROM pg_stat_activity where application_name IS NOT NULL AND state = 'active';
