select extract (epoch from age ('2018-01-31'::date,'2013-01-01'::date) ) /
86400,'2018-01-31'::date-'2013-01-01'::date
