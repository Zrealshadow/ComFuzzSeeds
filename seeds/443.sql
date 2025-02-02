SELECT VAR_SAMP(x::float8), COVAR_SAMP(x, x), VAR_SAMP(x)
FROM (SELECT 1000000.01 as x UNION SELECT 999999.99 as x) AS x;

SELECT VAR_SAMP(x::float8), COVAR_SAMP(x, x), VAR_SAMP(x)
FROM (SELECT 10000000.01 as x UNION SELECT 9999999.99 as x) AS x;
