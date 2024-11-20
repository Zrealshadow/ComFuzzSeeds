SELECT  NOW() - query_start AS elapsed, pid, client_addr, query, query_start, *
FROM pg_stat_activity
WHERE query != '<IDLE>'  AND query NOT ILIKE '%pg_stat_activity%'
ORDER BY query_start DESC;

SELECT typ.oid, att.attname, att.atttypid
FROM pg_type AS typ
JOIN pg_namespace AS ns ON (ns.oid = typ.typnamespace)
JOIN pg_class AS cls ON (cls.oid = typ.typrelid)
JOIN pg_attribute AS att ON (att.attrelid = typ.typrelid)
WHERE (typ.typtype = 'c' AND cls.relkind='c') AND attnum > 0 AND NOT attisdropped
ORDER BY typ.oid, att.attnum;
