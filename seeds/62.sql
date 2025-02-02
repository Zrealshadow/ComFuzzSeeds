ROLLBACK; BEGIN;

CREATE TABLE btree_bug (
    id BIGSERIAL,
    rand BIGINT NOT NULL
);

INSERT INTO btree_bug
    SELECT i, random() * 100000::BIGINT
        FROM generate_series(0, 10000) AS i;

CREATE INDEX ON btree_bug USING btree(rand);

SELECT 'Uses index:';
EXPLAIN ANALYZE SELECT id FROM btree_bug ORDER BY rand DESC NULLS FIRST
LIMIT 10;
EXPLAIN ANALYZE SELECT id FROM btree_bug ORDER BY rand ASC NULLS LAST LIMIT
10;


SELECT 'Does not use index:';
EXPLAIN ANALYZE SELECT id FROM btree_bug ORDER BY rand DESC NULLS LAST LIMIT
10;
EXPLAIN ANALYZE SELECT id FROM btree_bug ORDER BY rand ASC NULLS FIRST LIMIT
10;
