SELECT version();
SET TimeZone='UTC';
select * from pg_timezone_names where name like 'America/Los_Angeles';
select now()
 , now() at time zone 'America/Los_Angeles' as correct
 , now() at time zone '-07:00:00' as wrong;
select timestamptz'2021-10-01 00:00:00 UTC' at time zone 'America/Los_Angeles' as correct_1
 , timestamptz'2021-10-01 00:00:00 UTC' at time zone '-07:00' as wrong_1
 , timestamptz'2021-10-01 00:00:00 America/Los_Angeles' at time zone 'America/Los_Angeles' as correct_2
 , timestamptz'2021-10-01 00:00:00 -07:00:00' at time zone '-07:00' as wrong_2
 , timestamptz'2021-10-01 00:00:00 -07:00:00' at time zone 'America/Los_Angeles' as correct_3
 , timestamptz'2021-10-01 00:00:00 America/Los_Angeles' at time zone '-07:00' as wrong_3;
