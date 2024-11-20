select length(substr('   '::varchar,1,1)), ascii(substr('   '::varchar,1,1));
select length(substr('   '::char,1,1)), ascii(substr('   '::char,1,1));
