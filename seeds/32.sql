select 'somethingelse'::tsvector @@ '!foo'::tsquery;
select ''::tsvector @@ '!foo'::tsquery;
