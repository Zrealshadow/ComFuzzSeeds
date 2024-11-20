WITH table1 AS (
     SELECT 2 AS city_id, 5 AS cnt
     UNION ALL
     SELECT 2 AS city_id, 1 AS cnt
     UNION ALL
     SELECT 3 AS city_id, 2 AS cnt
     UNION ALL
     SELECT 3 AS city_id, 7 AS cnt
	), 
 
fin AS (
	SELECT 
	    coalesce(country_id, city_id) AS location_id,
	    total
	FROM (
		SELECT
			1 as country_id,
			city_id,
			sum(cnt) as total
		FROM table1 
		GROUP BY GROUPING SETS (1,2)
		) base
	)
	
SELECT * 
FROM fin 
WHERE location_id = 1;
