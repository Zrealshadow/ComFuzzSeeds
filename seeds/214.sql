SELECT
0
FROM (SELECT
      TRUE as "r",
      SUM(0)
      ) as "T1",
LATERAL
(SELECT TRUE as "b"
	UNION ALL
	SELECT
	"r" as "b"
	FROM (SELECT 0 ORDER BY COALESCE(0)) as "T1"
	) as "T2"
WHERE "b"
