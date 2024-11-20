select to_tsvector('simple', 'bla bla ./aaa bla bla'),
       phraseto_tsquery('simple', './aaa'),
       to_tsvector('simple', 'bla bla ./aaa bla bla') @@
phraseto_tsquery('simple', './aaa') as matches;

select
  quote_literal(text1) as qtext1,
  quote_literal(text2) as qtext2,
  ts_vector1,
  ts_vector2,
  array(select alias || ':' || quote_literal(token) from ts_debug('simple',
text1)) as ts_debug1,
  array(select alias || ':' || quote_literal(token) from ts_debug('simple',
text2)) as ts_debug2,
  ts_vector1 @@ phraseto_tsquery(text2) as phraseto_match
from
  unnest(array['', ')']) as zz0(prefix),
  (select chr(a) as char1 from generate_series(1,128) as s1(a) where (a not
between 49 and 57) and (a not between 65 and 90) and (a not between 98 and
122)) as zz1,
  (select chr(a) as char2 from generate_series(1,128) as s1(a) where (a not
between 49 and 57) and (a not between 65 and 90) and (a not between 98 and
122)) as zz2,
  (select chr(a) as char3 from generate_series(1,128) as s1(a) where (a not
between 49 and 57) and (a not between 65 and 90) and (a not between 98 and
122)) as zz3,
  lateral (select prefix ||          char1 || char2 || char3 as text1,
           prefix || ' '   || char1 || char2 || char3 as text2,
 prefix ||          char1 || char2 || ' ' as text11,
 prefix || ' '   || char1 || char2 || ' ' as text22) zz4,
  lateral (select to_tsvector('simple', text1) as ts_vector1,
           to_tsvector('simple', text2) as ts_vector2,
   to_tsvector('simple', text11) as ts_vector11,
   to_tsvector('simple', text22) as ts_vector22) as zz8
where
  ts_vector1 != ts_vector2
  and (ts_vector11 = ts_vector22 or char3 = ' ')
;

select version();
