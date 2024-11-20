SELECT lo_create(41174);
DO $$
BEGIN
   PERFORM lo_export(41174, '/invalid/path');
EXCEPTION
   WHEN others THEN RAISE NOTICE 'error: %', sqlerrm;
END;
$$;
