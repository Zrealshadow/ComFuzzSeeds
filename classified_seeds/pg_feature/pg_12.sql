drop schema if exists bug_showcase cascade;
create schema bug_showcase;
set search_path to bug_showcase;

CREATE TABLE  test_table (
    chec_key UUID  NOT NULL  ,
   some_date  date,
    some_data_2 varchar,
     some_data_3 varchar,
      some_data_4 varchar
    );

DO $$
BEGIN
 FOR i IN 0..15 LOOP
   EXECUTE 'CREATE TABLE test_table_'||to_hex(i)||' ( CHECK (chec_key >= UUID '''||to_hex(i)||'0000000-0000-0000-0000-000000000000'' AND chec_key <= UUID '''||
        to_hex(i)||'fffffff-ffff-ffff-ffff-ffffffffffff'' ) ) INHERITS (test_table);';
        EXECUTE 'CREATE INDEX test_table_'||to_hex(i)||'_brin on test_table_'||to_hex(i)||' USING brin (chec_key, some_date);';
    END LOOP;
END$$;

drop index test_table_4_brin;

DO $$
BEGIN
 FOR i IN 0..15 LOOP
        EXECUTE 'create index partial_not_working_'||to_hex(i)||' on test_table_4 USING brin ( chec_key, some_date) where (chec_key >= UUID ''4'||to_hex(i)||'000000-0000-0000-0000-000000000000'' AND chec_key <= UUID ''4'||
        to_hex(i)||'ffffff-ffff-ffff-ffff-ffffffffffff'' );';
END LOOP;   
END$$;

insert into test_table_1  (chec_key , some_date , some_data_2 , some_data_3,some_data_4 ) select  
uuid('1'||lpad(to_hex(i),5,'0')||'00-0000-4000-a000-000000000000'),date '2015-10-1' + random() *  interval '2 days' ,md5(random()::text)
,md5(random()::text),md5(random()::text)  from generate_Series(0,1048575) i ;
insert into test_table_3  (chec_key , some_date , some_data_2 , some_data_3,some_data_4  ) select  
uuid('3'||lpad(to_hex(i),5,'0')||'00-0000-4000-a000-000000000000'),date '2015-10-1' + random() *  interval '2 days' ,md5(random()::text)
,md5(random()::text),md5(random()::text)  from generate_Series(0,1048575) i ;
insert into test_table_4  (chec_key , some_date , some_data_2 , some_data_3,some_data_4  ) select  
uuid('4'||lpad(to_hex(i),5,'0')||'00-0000-4000-a000-000000000000'),date '2015-10-1' + random() *  interval '2 days' ,md5(random()::text)
,md5(random()::text),md5(random()::text)  from generate_Series(0,1048575) i ;
insert into test_table_7  (chec_key , some_date , some_data_2 , some_data_3,some_data_4  ) select  
uuid('7'||lpad(to_hex(i),5,'0')||'00-0000-4000-a000-000000000000'),date '2015-10-1' + random() *  interval '2 days' ,md5(random()::text)
,md5(random()::text),md5(random()::text)  from generate_Series(0,1048575) i ;

analyse test_table;

set enable_seqscan = off;
explain select * from test_table where chec_key  in ('4400df00-0000-4000-a000-000000000000' )and some_date <'2015-11-02';
explain select * from test_table where chec_key  in ('4400df00-0000-4000-a000-000000000000','4401df00-0000-4000-a000-000000000000' )and some_date <'2015-11-02';
explain select * from test_table where chec_key  in ('4400df00-0000-4000-a000-000000000000','1400df00-0000-4000-a000-000000000000')and some_date <'2015-11-02';
