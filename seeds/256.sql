SELECT * FROM generate_series(1, 1) a WHERE a = ANY (array[array[NULL::int]]);
