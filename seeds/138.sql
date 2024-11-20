select
 c.oid, schemaname, relname , t.tablespace "curr ts" , relpersistence
  from pg_class c, pg_tables t
where
t.tablespace in ('ts_data2',  'ts_data3')
