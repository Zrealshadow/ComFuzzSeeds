with s1 as (select 'a r' c), s2 as (select 'ara' c), s3 as (select 'a s' c) select c from (select c from s1 union all select c from s2 union all select c from s3) as foo order by 1;
with s1 as (select 'a r' c), s2 as (select 'ara' c), s3 as (select 'a q' c) select c from (select c from s1 union all select c from s2 union all select c from s3) as foo order by 1;
with s1 as (select 'a r' c), s2 as (select 'ara' c), s3 as (select 'a r' c) select c from (select c from s1 union all select c from s2 union all select c from s3) as foo order by 1;
with s1 as (select 'a r' c), s2 as (select 'ara' c), s3 as (select 'a s' c) select c from (select c from s1 union all select c from s2 union all select c from s3) as foo order by 1;
with s1 as (select 'a j' c), s2 as (select 'aja' c), s3 as (select 'a i' c) select c from (select c from s1 union all select c from s2 union all select c from s3) as foo order by 1;
with s1 as (select 'a j' c), s2 as (select 'aja' c), s3 as (select 'a j' c) select c from (select c from s1 union all select c from s2 union all select c from s3) as foo order by 1;
with s1 as (select 'a j' c), s2 as (select 'aja' c), s3 as (select 'a k' c) select c from (select c from s1 union all select c from s2 union all select c from s3) as foo order by 1;
