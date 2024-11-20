select name, setting, unit, source, pending_restart from pg_settings where source <> 'default' and context <> 'internal' order by lower(name) ;
select version();
