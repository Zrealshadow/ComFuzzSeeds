SELECT c.relname FROM pg_class c WHERE c.relname ~ '^(tdocument*)$';
SELECT c.relname FROM pg_class c WHERE c.relname ~* '^(tdocument*)$';
