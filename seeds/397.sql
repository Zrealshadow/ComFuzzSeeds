select *
from (
         select jsonb_path_query_array(module -> 'lectures', '$[*]') as lecture
         from unnest(
             array[$${
               "lectures": [
                 {
                   "id": "1"
                 }
               ]
             }$$::jsonb]) as unnested_modules(module)
     ) as l,
     jsonb_to_recordset(l.lecture) as (id text)
limit 1;
