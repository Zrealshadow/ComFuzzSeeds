select to_tsvector('x y z') @@ to_tsquery('x <-> y <-> z');
select to_tsvector('x y z') @@ to_tsquery('x <-> (y <-> z)');
select to_tsquery('(b <-> a) <-> c');
select to_tsquery('b <-> (a <-> c)');
