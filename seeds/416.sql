WITH r1 AS (VALUES(null)),
r2 AS (VALUES(null), (null))
SELECT ljl.val_filtered
FROM r1
LEFT JOIN(
	SELECT j666.val FROM r2
	JOIN (SELECT 666 AS val) as j666 ON true
)AS lj_r2 ON true
LEFT JOIN LATERAL(
	SELECT lj_r2.val AS val_filtered
	WHERE false
) AS ljl ON true;
