select pid,state,substr(query,0,100) from pg_stat_activity where query ~ 'ela_elifeassist_product';
select a.locktype,a.pid,a.relation,a.mode,a.granted,b.relname from pg_locks a,pg_class b where a.relation=b.oid and relname='ela_elifeassist_product';
select relname,relpages,relallvisible from pg_class where relname ='ela_elifeassist_product';
