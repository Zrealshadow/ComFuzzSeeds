select json_agg(row_to_json(x)) from (select *, null from generate_series(1, 3)) x;
select json_agg(row_to_json(x)) from (select *, row_to_json(null) as jjj from generate_series(1, 3)) x;
select json_agg(row_to_json(x)) from (select *, row_to_json(null) from generate_series(1, 3)) x;
