SELECT
	sp2.spf_id 
FROM
	information_schema.sql_parts AS sp
	CROSS JOIN LATERAL ( SELECT sizing_id FROM information_schema.sql_sizing )
AS ss
	CROSS JOIN LATERAL ( SELECT sp.feature_id AS spf_id ) AS sp2
GROUP BY
	CUBE ( sp2.spf_id )
