SELECT
        "q2"."v"
    FROM
        LATERAL
        (SELECT
                "q11"."v"
            FROM
                (
                    (SELECT 2::bigint AS "v") UNION ALL
                    (SELECT 3::bigint AS "v")
                ) AS "q11"
        ) AS "q1"
        CROSS JOIN LATERAL
        (
            (SELECT
                "q3"."v"
             FROM
                (
                    (SELECT 4::bigint AS "v") UNION ALL
                    (SELECT 5::bigint AS "v")
                ) AS "q3"
            )
            UNION ALL
            (SELECT "q1"."v")
        ) AS "q2"
    ORDER BY
        "q2"."v";
