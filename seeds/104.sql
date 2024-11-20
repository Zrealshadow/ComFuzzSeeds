WITH RECURSIVE

run(x, y) AS (
  SELECT 0, 0
  UNION ALL
  SELECT x, y FROM run AS r WHERE r.is_cycle
)
CYCLE x, y SET is_cycle USING path

TABLE run
;
