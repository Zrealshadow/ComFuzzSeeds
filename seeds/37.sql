select 'a' || ' ' || 'b';
select 'a' || N' ' || 'b';
explain (analyze, verbose) select concat(concat('a', ' '), 'b');
explain (analyze, verbose) select concat(concat('a', N' '), 'b');
select 'a' || char ' ' || 'b';
