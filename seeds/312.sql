DO $$
DECLARE 
   v varchar;

BEGIN

   v := 'ABCŸ';

EXCEPTION

WHEN others THEN
RAISE INFO 'Error State: %', SQLSTATE;

END$$;
