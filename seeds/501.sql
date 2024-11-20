SELECT count(*) FROM pg_class WHERE relkind = 'r';
SELECT count(*) FROM pg_class WHERE relkind = 'i';
SELECT count(*) FROM (SELECT * FROM pg_class WHERE relkind = 'r' UNION SELECT * FROM pg_class WHERE relkind = 'i');
EXPLAIN (ANALYZE) SELECT count(*) FROM (SELECT * FROM pg_class WHERE relkind = 'r' UNION SELECT * FROM pg_class WHERE relkind = 'i');
SELECT * FROM pg_class WHERE relkind = 'r' UNION SELECT * FROM pg_class WHERE relkind = 'i';
