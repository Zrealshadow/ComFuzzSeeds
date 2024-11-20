SELECT '[]'::JSONB < j::JSONB
FROM (VALUES
  ('null'),
  ('"a"'),
  ('1'),
  ('[1]'),
  ('{}')
) v(j);
