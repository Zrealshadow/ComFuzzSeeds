select 1
from 
 (
  select count(case t1.a when 1 then 1 else null end) over (partition by t2.b) c
  from  (select 1 a) t1, (select 1 b) t2
 ) t
where t.c = 1
