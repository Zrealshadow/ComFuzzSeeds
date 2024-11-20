explain (costs off) select * from pg_class where oid is null;
explain select c1.* from pg_class c1 inner join pg_class c2 on c1.oid=c2.oid;
explain (costs off) select * from pg_class where oid is null or relname = 'non-existent';
