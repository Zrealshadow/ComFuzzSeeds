select ltrim('TRYTND', 'TRY');
select ltrim('TRYUSD', 'TRY');
select substring('TRYTND', length('TRY')+1, length('TRYTND'));
select substring('TRYUSD', length('TRY')+1, length('TRYUSD'));
