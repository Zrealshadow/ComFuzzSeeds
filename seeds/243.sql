select * from pg_catalog.pg_tables;
select * from pg_catalog.pg_tables where tablename = 'm_rt_temp';
select * from pg_catalog.pg_tables where tablename like 'm_%';
select * from pg_catalog.pg_tables where tablename like '% m_rt_temp%';
select * from pg_catalog.pg_tables where tablename like '% m_rt_temp';
select * from pg_catalog.pg_tables where tablename like '_m_rt_temp';
SELECT *, ASCII (SUBSTR (tablename, 1,1)) FROM pg_catalog.pg_tables where schemaname = 'public' and tablename like ('% m_rt_temp%');
