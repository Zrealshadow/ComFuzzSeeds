CREATE OR REPLACE VIEW foo AS SELECT 1;
DROP VIEW foo;
SELECT definition FROM pg_views;
