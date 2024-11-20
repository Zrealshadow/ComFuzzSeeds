with dataset as (
	select 'One' "Label", 1 "ID"
	union
	select 'Two' "Label", 2 "ID"
	union
	select 'Three' "Label", 3 "ID"
)
select
	string_agg(', ', "Label" order by "ID") "String Aggregated Labels",
	array_agg("Label" order by "ID") "Array Aggregated Labels"
from
	dataset
;
