select extract(epoch from age(TIMESTAMP '2013-02-18 06:15:15'));
select (extract(epoch from now()) - extract(epoch from TIMESTAMP '2013-02-18 06:15:15'));
