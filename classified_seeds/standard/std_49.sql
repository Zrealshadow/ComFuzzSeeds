select
col1, col2, jsonb_each_text(col2)
from (
select 1 as col1, null::jsonb as col2
union all
select 1 as col1, '{"a":"2"}'::jsonb as col2
) t1
