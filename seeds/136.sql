DO LANGUAGE plpgsql $$
DECLARE
  jsonb_result jsonb;
  count int;
BEGIN
  count = 0;
  LOOP
    -- Impl #1
--     jsonb_result = jsonb_object_agg('created', now() );

    -- Impl #2
    select to_jsonb(t) from (select now() as "created") t
    into jsonb_result;

    count = count + 1;
    EXIT WHEN count > 500000;
  END LOOP;

  raise notice 'result = %', jsonb_result;
END; $$
