WITH raw_data(id, value) AS (VALUES (1, '1900'), (2, '2100'), (3, 'abc')),
     integers AS (SELECT value::integer
                  FROM raw_data
                  WHERE value ~ '^\\d+$')
SELECT COUNT(*)
FROM integers
WHERE value < 2000;
