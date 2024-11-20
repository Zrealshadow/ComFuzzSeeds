select ts_rank(doc1, query) as rank_wrong, ts_rank(doc2, query) as rank_correct
from (select setweight(to_tsvector('simple', 'foo something'), 'A') ||
             setweight(to_tsvector('simple', 'foobar'), 'C')    as doc1,
             setweight(to_tsvector('simple', 'foo something'), 'A') as doc2,
             to_tsquery('simple', 'foo:* & something')               as query) as subquery;
