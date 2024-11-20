select name,unnest(test_values.int_array) as array_item from
(select 'test_a' as name,null :: int[] as int_array union all
select 'test_b' as name ,array[1,2,3] as int_array ) test_values
