select json_object(ARRAY['moo', 'woof'], ARRAY['cow', 'dog'])::text;
select jsonb_object(ARRAY['moo', 'woof'], ARRAY['cow', 'dog'])::text;
select to_json('{"moo":        "cow"}'::jsonb);
select cast('{"moo":        "cow"}'::jsonb as json);
