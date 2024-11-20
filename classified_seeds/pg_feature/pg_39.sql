SELECT oid,
       typname,
       typcategory,
       CASE
          WHEN typcategory = 'N' THEN 'Numeric types'
          WHEN typcategory = 'S' THEN 'String types'
          WHEN typcategory = 'E' THEN 'Enum types'
          ELSE typcategory
       END AS test_case_fails,
       CASE
          WHEN typcategory = 'N' THEN 'Numeric types'
          WHEN typcategory = 'S' THEN 'String types'
          WHEN typcategory = 'E' THEN 'Enum types'
       END AS test_case_works_no_else,
       CASE
          WHEN typcategory = 'N' THEN 'Numeric types'
          WHEN typcategory = 'S' THEN 'String types'
          WHEN typcategory = 'E' THEN 'Enum types'
          ELSE typname
       END AS test_case_works_other_col,
       CASE
          WHEN typcategory = 'N' THEN 'Numeric types'
          WHEN typcategory = 'S' THEN 'String types'
          WHEN typcategory = 'E' THEN 'Enum types'
          ELSE 'ELSE'
       END AS test_case_works_constant
FROM pg_type
ORDER BY oid
LIMIT 10
;
