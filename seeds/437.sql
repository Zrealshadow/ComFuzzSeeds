SELECT Max(Val) FROM (VALUES (1, 5), (2, 6), (NULL, 7)) AS T(Val, ID);
SELECT Max(ARRAY[Val, ID]) FROM (VALUES (1, 5), (2, 6), (NULL, 7)) AS T(Val, ID);
SELECT Min(ARRAY[-Val, ID]) FROM (VALUES (1, 5), (2, 6), (NULL, 7)) AS T(Val, ID);
