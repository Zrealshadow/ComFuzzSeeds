with w_degree as (
                   select 0::integer as degree union all
                   select 1::integer as degree union all
                   select 2::integer as degree union all
                   select 3::integer as degree union all
                   select 4::integer as degree union all
                   select 5::integer as degree union all
                   select 6::integer as degree union all
                   select 7::integer as degree union all
                   select 8::integer as degree union all
                   select 9::integer as degree
                 )
select
  power(10, w.degree::integer)                                  as "power()"
, 1.11::numeric(20, 5) * power(10, w.degree::integer)           as " 1.11 * power()"
, 1.11::numeric(20, 5) * power(10, w.degree::integer)::integer  as " 1.11 * power()::integer"
, 69.96::numeric(20, 5) * power(10, w.degree::integer)          as "69.96 * power()"
, 69.96::numeric(20, 5) * power(10, w.degree::integer)::integer as "69.96 * power()::integer"
from w_degree w;
