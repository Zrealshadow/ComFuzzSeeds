WITH RECURSIVE
steps(i) AS (
  SELECT 1
    UNION
  SELECT val.x
  FROM steps AS s,
  LATERAL (
    VALUES
    ((SELECT s.i + 1)), 
    (s.i + 1)
  ) AS val(x)
  WHERE s.i < 10
)
SELECT *
FROM steps;
