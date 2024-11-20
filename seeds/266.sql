select jsonb_path_query('{}', '($[0] like_regex "").type()');
