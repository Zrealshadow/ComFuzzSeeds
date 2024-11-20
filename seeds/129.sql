SELECT ts_rank_cd(to_tsvector('This function calculates the coverage density'), to_tsquery('function | calculates'), 4); -- 0.1
SELECT ts_rank_cd(to_tsvector('This function calculates the coverage density'), to_tsquery('function'), 4);              -- 0.1
SELECT ts_rank_cd(to_tsvector('This function calculates the coverage density'), to_tsquery('function | calculates'), 1); -- 0.124
SELECT ts_rank_cd(to_tsvector('This function calculates the coverage density'), to_tsquery('function'), 1);              -- 0.062
SELECT ts_rank_cd(to_tsvector('This function calculates the coverage density'), to_tsquery('function | calculates'), 4|1); -- 0.062 (X)
SELECT ts_rank_cd(to_tsvector('This function calculates the coverage density'), to_tsquery('function'), 4|1);              -- 0.062 (Y)
