SELECT token, lexemes, lexemes = '{}'::text[]
FROM   ts_debug('a title');

SELECT token, dictionaries, lexemes
     , array_dims(lexemes) AS lex_dims
     , array_dims(dictionaries) AS dict_dims
FROM   ts_debug('a title');
