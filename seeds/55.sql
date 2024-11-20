select
  cume_dist(1) within group (order by a desc),
  rank(1) within group (order by a desc),
  dense_rank(1) within group (order by a asc),
  percent_rank(1) within group (order by a asc)
from (values(1)) t(a);
SELECT version();
