SELECT
    '2021-01-01'::date AS month
GROUP BY
    rollup(month)
ORDER BY
    month NULLS FIRST;
