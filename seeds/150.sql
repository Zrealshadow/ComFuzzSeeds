DO $$
DECLARE
  arr real[];
  jsarr jsonb;
  arr2 real[];
BEGIN
  arr[3] = 1.1;
  arr[4] = 1.1;
  raise notice 'arr = %', arr;

  jsarr = array_to_json(arr);
  raise notice 'arr = %', jsarr;

  arr[0] = 1.1;
  raise notice 'arr = %', arr;

  jsarr = array_to_json(arr);
  raise notice 'arr = %', jsarr;
END $$
