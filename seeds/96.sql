SELECT tq, text, text @@ tq AS ok,  repeat(' foo ',16381) || text @@ tq AS false_pos
FROM (VALUES( websearch_to_tsquery('"red cat"'), 'red dogs chase with black cats' )) t(tq, text) ;

SELECT tq, text, text @@ tq AS small,  repeat(' foo ',16381) || text @@ tq AS false_neg
FROM (VALUES( websearch_to_tsquery('"black cat"'), 'red dogs chase with black cats' )) t(tq, text) ;
