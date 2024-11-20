SELECT pg_class.relname
FROM pg_class, pg_index
WHERE pg_index.indisvalid = false
AND pg_index.indexrelid = pg_class.oid;
