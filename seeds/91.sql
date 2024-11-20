with q_data as (
  select '1' as testa, 1 as testb 
  union
  select '2' as testa, 2 as testb 
  union
  select '3' as testa, 3 as testb 
  union
  select '4' as testa, 4 as testb 
)
select array_agg(q) || array_agg(q) from q_data q;
