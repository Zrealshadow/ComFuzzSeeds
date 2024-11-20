select ts_headline('Alpha Beta Gama', phraseto_tsquery ('alpha gama'));
select ts_headline('Alpha Beta Gama', to_tsquery ('alpha <-> gama'));
select ts_headline('Alpha Beta Gama Delta', phraseto_tsquery ('alpha <3> gama'));
