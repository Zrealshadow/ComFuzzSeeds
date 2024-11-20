select *, item as item
from (select '[1]'::jsonb as items) as d
left join jsonb_array_elements(d.items) as item on true;

select *, item as item
from (select *, jsonb_array_elements(d.items) as item
from (select '[1]'::jsonb as items) as d) as f;

select *, item as item
from (select '{1}'::text[] as items) as d
left join unnest(d.items) as item on true;
