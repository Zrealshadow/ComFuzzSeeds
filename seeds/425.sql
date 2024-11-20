select websearch_to_tsquery('german', 'foo or baz bar');
select websearch_to_tsquery('german', 'foo or baz bar or ding dong');
select websearch_to_tsquery('german', 'foo or baz bar or (ding dong)');
select websearch_to_tsquery('german', 'foo or (baz bar) or (ding dong)');
