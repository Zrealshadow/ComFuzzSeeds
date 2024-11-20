select name,setting from pg_settings where name like 'ssl_%' order by name;
select pg_reload_conf();
select pg_reload_conf();
select pg_reload_conf();
