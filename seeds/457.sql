SELECT NULL IN (1, 2);
SELECT (1, NULL::int) IN ((1, 1), (1, 2));
SELECT 1 < NULL;
SELECT (1, NULL::int) > (1, 2);
SELECT (1, (1, NULL::int)) IN ((1, (1, 0)), (1, (1, 2)));
SELECT (1, (1, NULL::int)) > (1, (1, 2));
