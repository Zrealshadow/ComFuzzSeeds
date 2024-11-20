WITH test(id, not_id) AS (
  SELECT * FROM (VALUES (1,1), (3,4)) AS t
),

test2(id1) AS (
  SELECT * FROM (VALUES (2), (3) ) AS t
)

SELECT * FROM test WHERE id IN ( SELECT not_id FROM test2 );
