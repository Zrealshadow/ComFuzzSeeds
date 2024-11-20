select jsonb_path_query('{"data": [{"key": "value"}]}', '$.**.key')
