SELECT * FROM (VALUES (1)) AS t(id)
    CROSS JOIN unnest('{1,2}'::int[]) AS a(x)
    FULL JOIN unnest('{2,3}'::int[]) AS b(x) ON a.x = b.x
WHERE t.id = 1;

SELECT * FROM (VALUES (1)) AS t(id)
    CROSS JOIN unnest('{1,2}'::int[]) AS a(x)
    FULL JOIN unnest('{2,3}'::int[]) AS b(x) ON a.x = b.x;

SELECT * FROM (VALUES (1)) AS t(id), unnest('{1,2}'::int[]) AS a(x)
    FULL JOIN unnest('{2,3}'::int[]) AS b(x) ON a.x = b.x
WHERE t.id = 1;
