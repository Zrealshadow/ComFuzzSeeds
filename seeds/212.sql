select websearch_to_tsquery('english', '"pg_class pg"');
select to_tsvector('pg_class pg') @@ websearch_to_tsquery('"pg_class pg"');
select to_tsvector('pg_class pg') @@ to_tsquery('pg <-> class <-> pg');
