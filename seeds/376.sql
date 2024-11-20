select to_tsvector('english', 'aaa: bbb') @@ websearch_to_tsquery('english', '"aaa: bbb"');
select to_tsvector('english', 'aaa: bbb'), websearch_to_tsquery('english', '"aaa: bbb"');
select text, ts_vector, ts_query, matches from unnest(array['', ' ']) as prefix, unnest(array['', ' ']) as suffix, (select chr(a) as char from generate_series(1,192) as s(a)) as zz1, lateral (select 'aaa' || prefix || char || suffix || 'bbb' as text) as zz2, lateral (select to_tsvector('english', text) as ts_vector) as zz3, lateral (select websearch_to_tsquery('english', '"' || text || '"') as ts_query) as zz4, lateral (select ts_vector @@ ts_query as matches) as zz5 where not matches;
select version();
