SELECT oid, (SELECT oid FROM pg_type WHERE typname like 'geography') as dd  FROM pg_type WHERE typname like 'geometry'
