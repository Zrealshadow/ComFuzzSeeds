with a(x) as(
               values
('{[10,20],[100,200]}'::int4multirange)
,('{[20,40],[15,55],[100,200]}'::int4multirange)
)
select range_agg(x)
from (
               select unnest(x)x
               from a
)t;

with a(x) as(
               values
('{[10,20],[100,200]}'::int4multirange)
,('{[20,40],[15,55],[100,200]}'::int4multirange)
)
select range_intersect_agg(x)
from a;
