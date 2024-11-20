WITH test_cte AS (SELECT 1 AS id, 2 AS qty)
SELECT COALESCE(SUM(qty), 0) FROM test_cte WHERE id=2;

WITH test_cte AS (SELECT 1 AS id, 2 AS qty)
SELECT COALESCE((SELECT SUM(qty) FROM test_cte WHERE id=2), 0);
