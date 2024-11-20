SELECT * FROM 
(VALUES ('null'::jsonb), ('[]'::jsonb), ('[null]'::jsonb), ('[[]]'::jsonb)) AS t(j) 
ORDER BY j;
