SELECT ts_rank(to_tsvector('lets eat a cat'), ('fat & bat | rat'::tsquery && 'cat'::tsquery));
SELECT ts_rank(to_tsvector('lets eat a fat cat'), ('fat & bat | rat'::tsquery && 'cat'::tsquery));
