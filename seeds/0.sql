listen test;
select pg_sleep(5);
notify test, 'test1';
notify test, 'test2';
