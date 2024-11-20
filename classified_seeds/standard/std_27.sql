SELECT 0
      FROM
      (SELECT 0) as "T1"
      LEFT OUTER JOIN
      (SELECT * FROM (SELECT *
        FROM
        (SELECT
         0) as "T1"
        LEFT OUTER JOIN
        (SELECT
         TRUE as "r") as "T2"
        ON
        TRUE) as "T1",
       LATERAL
       (SELECT
        TRUE as "b"
        UNION ALL
        SELECT
        CASE WHEN "r" THEN TRUE ELSE TRUE END as "b") as "T2"
        ) as "T2"
      ON
      "b"
