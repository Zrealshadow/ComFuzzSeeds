create table tmp_test(id int not null, test text not null);
create unique index on tmp_test(id);
INSERT INTO tmp_test VALUES (1, 'test');
create table tmp_test2(id int not null, test text not null);
WITH updated AS (UPDATE tmp_test SET test = 'test' WHERE id = 1 RETURNING id), inserted AS (INSERT INTO tmp_test2 (id, test) SELECT 1, 'test' WHERE NOT EXISTS (SELECT 1 FROM updated) RETURNING id) SELECT * FROM updated;
begin;
UPDATE tmp_test SET test = 'test' WHERE id = 1;
commit;
WITH updated AS (UPDATE tmp_test SET test = 'test' WHERE id = 1 RETURNING id), inserted AS (INSERT INTO tmp_test2 (id, test) SELECT 1, 'test' WHERE NOT EXISTS (SELECT 1 FROM updated) RETURNING id) SELECT * FROM updated;
