select count(*) from pg_stat_activity where state = 'active' and wait_event = 'MultiXactOffsetControlLock';
