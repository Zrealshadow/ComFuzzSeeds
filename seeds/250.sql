UPDATE pg_database SET datallowconn = 't' WHERE datname = 'template0';
SELECT txid_current();
SELECT txid_status(3);
SELECT pg_xact_status('3'::xid8);
