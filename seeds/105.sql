select pg_get_triggerdef(t.oid)
from pg_catalog.pg_trigger t
