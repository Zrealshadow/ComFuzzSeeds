WITH sample AS (SELECT 'c' AS t) SELECT CASE WHEN t IN ('a','b') THEN 1
WHEN t IN ('c'
  'd') THEN 2 END FROM sample;

WITH sample AS (SELECT 'c' AS t)
SELECT * FROM sample WHERE t IN ('a'
'c');
