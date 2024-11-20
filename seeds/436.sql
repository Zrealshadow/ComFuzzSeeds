select
  gs,
  gs + random() * 100 - 50 as gs2,
  random() * 100 - 50 as r1,
  random() * 100 - 50 as r2,
  random() * 100 - 50 as r3
from generate_series(0, 10) as gs
order by random();
