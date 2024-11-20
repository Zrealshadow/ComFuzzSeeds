SELECT jsonb_path_query('[1,2,3]' :: jsonb, '$');
SELECT jsonb_path_query('[1,2,3]' :: jsonb, '$[*]');
SELECT jsonb_path_query('[1,2,3]' :: jsonb, '$[*] ? (@ <> null)');
SELECT jsonb_path_query('[1,2,3]' :: jsonb, '$ ? (@ <> null)');
