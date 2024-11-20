select where 'ab' like '%a%';
select where 'ab'||NULL like '%a%';
select where 'ab'||NULL::text like '%a%';
select where 'ab'||format('%s', NULL::text) like '%a%';
select version();
