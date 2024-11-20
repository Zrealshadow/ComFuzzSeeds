SELECT pg_identify_object_as_address('pg_collation'::regclass,oid,0), * FROM pg_collation WHERE collname = 'en_GB';
