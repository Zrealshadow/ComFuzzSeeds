NOTIFY __test;
BEGIN;
SELECT pg_advisory_lock(7777);
SELECT pg_advisory_unlock(7777);
COMMIT;
NOTIFY __test;
SELECT pg_advisory_lock(7777);
SELECT pg_advisory_unlock(7777);
LISTEN __test;
SELECT pg_advisory_lock(7777);
SELECT pg_advisory_unlock(7777);
