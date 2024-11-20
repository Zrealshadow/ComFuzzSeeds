set jit_above_cost = 10;
EXPLAIN ANALYZE SELECT SUM(relpages) FROM pg_class;
