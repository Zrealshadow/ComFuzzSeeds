DO LANGUAGE plpgsql $$
DECLARE
  jsonb_src jsonb;
  jsonb_dst jsonb;
BEGIN
  jsonb_src = '{
    "key1": {"data1": [1, 2, 3]},
    "key2": {"data2": [3, 4, 5]}
  }';
  raise notice 'jsonb_src = %', jsonb_src;
  
  with t_data as (select * from jsonb_each(jsonb_src))
  select jsonb_object(
    array(select key from t_data),
    array(select value::text from t_data) )
  into jsonb_dst;
  raise notice 'jsonb_dst = %', jsonb_dst;
END $$;
