set enable_hashjoin to off;
set enable_hashagg to off;
set enable_nestloop to off;

explain 
select * 
from (
	select outr%2 o2,
		outr%5 o5
	from generate_series(1, 10) outr
	order by o2,
		  o5
) o
join (
	select innr%2 i2,
		innr%5 i5
	from generate_series(1, 10) innr
	where innr%2 = 0 
	group by innr%2,
		  innr%5
) i on o.o2 = i.i2
   and o.o5 = i.i5;
