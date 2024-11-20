WITH RECURSIVE rec(x) AS (
    WITH outermost(x) AS (
      SELECT (
        WITH innermost as (SELECT 1)
        SELECT * FROM innermost
      )
    )
    SELECT * FROM outermost
)
SELECT * FROM rec;
