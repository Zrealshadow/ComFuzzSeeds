SELECT row(NULL::int) = row(NULL::int) AS "test= ",
       row(NULL::int) IS NULL AS IS_NULL,
       row(NULL::int) IS NOT NULL AS NOT_NULL,
       row(NULL::int) IS DISTINCT FROM NULL AS IS_DISTINCT_FROM_NULL,
       row(NULL::int) IS NOT DISTINCT FROM NULL AS NOT_DISTINCT_FROM_NULL;

SELECT num_nulls(row(NULL::int), row(NULL::int, NULL::TEXT), row(NULL::int, 'Bob'::TEXT)),
       num_nonnulls(row(NULL::int), row(NULL::int, NULL::TEXT), row(NULL::int, 'Bob'::TEXT));

SELECT row(NULL::int, 'Bob'::TEXT) IS NULL AS Row_IsNULL,
       row(NULL::int, 'Bob'::TEXT) IS NOT NULL AS Row_NotNULL;

SELECT version();
