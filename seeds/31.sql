select a, a = '{}' from (select array_fill(null::integer, array[0]) as a) s;
