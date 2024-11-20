select '{"FirstName": "Phillip"}'::jsonb || '{"LastName": "Haydon"}'::jsonb;
select '{"User": {"FirstName": "Phillip"}}'::jsonb || '{"User": {"LastName": "Haydon"}}'::jsonb;
