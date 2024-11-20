select pid, count(case when fastpath then 1 end) as num_fastpath_locks from pg_locks where locktype = 'relation' group by pid having  count(case when fastpath then 1 end) > 16;

with locks as materialized (
select * from pg_locks
)  select * from locks join  (select pid, count(case when fastpath then 1 end) as num_fastpath_locks from locks where locktype = 'relation' group by pid having  count(case when fastpath then 1 end) > 16 limit 1) v on (locks.pid = v.pid);
