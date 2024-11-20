reindex table pg_statistic;
select starelid,staattnum from pg_statistic group by starelid,staattnum having count(*) > 1;
