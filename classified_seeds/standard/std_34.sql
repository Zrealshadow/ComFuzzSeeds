SELECT 1
FROM
(
    SELECT NULL::text AS AccountName
) Actual FULL JOIN (
    SELECT text 'foo'
    UNION ALL
    SELECT text 'bar'
) Expected (AccountName)
ON TRUE
WHERE Expected.AccountName IS NULL;
