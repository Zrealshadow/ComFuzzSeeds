DROP TABLE IF EXISTS mytbl1;
CREATE TABLE mytbl1 (
  col11            INT   NOT NULL,
  col12            TEXT  NOT NULL,
  extracol         INT
);
ALTER TABLE mytbl1 DROP COLUMN extracol;
select attname, attnum, attisdropped from pg_class, pg_namespace, pg_attribute 
  where attrelid = pg_class.oid and relnamespace = pg_namespace.oid and relname = 'mytbl1' and nspname = 'public';
DROP TABLE IF EXISTS mytbl1_log;
CREATE TABLE mytbl1_log (
  col11            INT   NOT NULL,
  col12            TEXT  NOT NULL,
  verb             TEXT  ,
  tuple            TEXT
);
CREATE OR REPLACE FUNCTION log() RETURNS TRIGGER LANGUAGE plpgsql
AS $$
BEGIN
    IF TG_OP = 'INSERT' THEN
        INSERT INTO mytbl1_log SELECT new_table.*, 'INS', 'NEW' FROM new_table;
    END IF;
    RETURN NULL;
END; $$;
CREATE TRIGGER log_insert_mytbl1 AFTER INSERT ON mytbl1
    REFERENCING NEW TABLE AS new_table
    FOR EACH STATEMENT EXECUTE PROCEDURE log();
insert into mytbl1 values (1001,'a'),(1000,'a');
