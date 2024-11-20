select * from generate_series(0,20) n1
  left join (
    select distinct on (id) * from (
      select n2 as id, n2+2 as a from generate_series(0,10) n2
      union all
      select n3+5 as id, n3+12 as a from generate_series(0,10) n3
    ) s1 order by id, a
  ) s2 on s2.id = n1 where 20 is distinct from s2.a;
