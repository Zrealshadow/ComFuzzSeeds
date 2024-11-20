create table test1(c1 int, c2 int);  
insert into test1 select random()*1000, random()*1000 from generate_series(1,10000); 

explain (analyze,verbose,timing,costs,buffers) select * from test1 where ctid not in (select max(ctid) from test1 group by c1,c2);

drop table test1;
create table test1(id int, c1 int, c2 int);  
insert into test1 select id, random()*1000, random()*1000 from generate_series(1,10000) t(id); 

explain (analyze,verbose,timing,costs,buffers) select * from test1 where id not in (select max(id) from test1 group by c1,c2);
