SET TIMEZONE TO 'Europe/Berlin';
PREPARE test AS
   SELECT '2021-03-15 14:10:03'::timestamptz;
SET TIMEZONE TO 'America/Chicago';
EXECUTE test;
SELECT '2021-03-15 14:10:03'::timestamptz;
