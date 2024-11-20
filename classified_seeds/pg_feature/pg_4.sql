select jsonb_set('{}'::jsonb, array['x', 'y'], to_jsonb(1::text), true);
select jsonb_set('{}'::jsonb, array['x'], null, true);
