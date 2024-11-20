select name  from pg_settings where name like '%lock%';
select name from pg_settings where name='trace_locks';
select version();
