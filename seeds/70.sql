( ( select 1,2,3 ) union ( select 4,5,6 order by 1,2 ) order by 1,2 ) except ( select 4,5,6 ) order by 1,2;
( ( select 1,2,3 ) union ( select 4,5,6 order by 1,2 ) ) except ( select 4,5,6 ) order by 1,2;
