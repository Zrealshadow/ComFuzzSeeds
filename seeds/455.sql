select to_tsvector('english', 'baz') @@ websearch_to_tsquery('english', 'foo bar or baz ');
select websearch_to_tsquery('english', 'foo bar or baz');
