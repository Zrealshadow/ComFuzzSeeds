WITH sample(operand, low, high, cnt) AS (
  VALUES 
	(10.5::float8, -1.797e+308::float8, 1.797e+308::float8, 1::int4),
	(10.5::float8, -1.797e+308::float8, 1.797e+308::float8, 2),
	(10.5::float8, -1.797e+308::float8, 1.797e+308::float8, 3),

	(1.797e+308::float8 / 2, -1.797e+308::float8, 1.797e+308::float8, 10),
	(-1.797e+308::float8 / 2, -1.797e+308::float8, 1.797e+308::float8, 10),

	(1.797e+308::float8 / 2, -1.797e+308::float8, 1.797e+308::float8, 16),
	(-1.797e+308::float8 / 2, -1.797e+308::float8, 1.797e+308::float8, 16),

	(1.797e+308::float8, -1.797e+308::float8 / 2, 1.797e+308::float8 / 2, 10),
	(-1.797e+308::float8, -1.797e+308::float8 / 2, 1.797e+308::float8 / 2, 10)
) SELECT width_bucket(operand, low, high, cnt) FROM sample;
