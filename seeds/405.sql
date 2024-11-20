select jsonb_path_query_array(col, '$.**.itemName')
from (
  values ('{"items": [{"itemName": "a", "items": [{"itemName": "b"}]}]}'::jsonb)
) as t(col)
