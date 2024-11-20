WITH cte AS MATERIALIZED (SELECT 'foo' k, '{"foo":"bar"}'::jsonb j)
SELECT j[k], j[k || ''] FROM cte;
