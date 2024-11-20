SELECT '{"Name":"Domen\\Ivan"}'::json ->> 'Name' = 'Domen\Ivan';
SELECT '{"Name":"Domen\\Ivan"}'::json ->> 'Name' LIKE 'Domen\Ivan';
SELECT '{"Name":"Domen\\Ivan"}'::json ->> 'Name' LIKE 'Domen\\Ivan';
