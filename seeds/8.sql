SELECT 
r, 
r IS NULL AS "is null", 
r IS NOT NULL AS "is not null"
FROM (VALUES(NULL,NULL), (5, NULL), (5, 5)) r
