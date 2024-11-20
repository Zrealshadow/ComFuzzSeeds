CREATE TYPE my_type AS (f1 integer);
CREATE TYPE my_type_2 AS (f2 my_type);
CREATE TABLE my_table (c1 my_type_2);
CREATE VIEW my_view AS SELECT ((C1).f2).f1 FROM my_table;
DROP TYPE my_type CASCADE;
SELECT * FROM pg_views;
