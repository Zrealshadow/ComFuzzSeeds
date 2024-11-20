select now();
select now() at time zone 'utc';
select (now() at time zone 'utc') at time zone 'utc';
select (ts at time zone 'utc') from (select now() at time zone 'utc' as ts) as t1;
