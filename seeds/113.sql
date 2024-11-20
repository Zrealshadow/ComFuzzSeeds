select pubname, count(*) from pg_publication_tables where pubname ~ 'focal' group by pubname;
