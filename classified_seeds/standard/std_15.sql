select i, hashint2(i::smallint), hashint4(i), hashint8(i::bigint) from generate_series(-10,10) i;
set enable_mergejoin = false ;
select v1 from generate_series(-10,-1) v1, generate_series(-15,-5) v2 where v1::integer = v2::bigint ;
set enable_mergejoin = false ;
select v1 from generate_series(-10,-1) v1, generate_series(-15,-5) v2 where v1::integer = v2::bigint ;
