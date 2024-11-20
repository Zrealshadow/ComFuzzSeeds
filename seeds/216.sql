SELECT c.oid
FROM pg_catalog.pg_class c
LEFT JOIN pg_catalog.pg_namespace n
ON n.oid OPERATOR(pg_catalog.=) c.relnamespace
WHERE c.relkind OPERATOR(pg_catalog.=) ANY
(array['r', 'S', 'v', 'm', 'f', 'p'])
  AND c.relname OPERATOR(pg_catalog.~) '^(table name)$'
  AND n.nspname OPERATOR(pg_catalog.~) '^(schema name)$'
