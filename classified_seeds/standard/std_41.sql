SELECT array_agg(distinct val) FROM (SELECT NULL AS val FROM generate_series(1, 2)) hoge;
