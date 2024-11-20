with d (a,b) as (values (null::varchar(255),1))
select * 
from d d1
full join d d2 using (a,b);
