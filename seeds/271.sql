select regexp_matches('a 1x1250x2500',
'(a).*?([1-9]\d*)\s*x\s*([1-9]\d*)(?:\s*x\s*([1-9]\d*))?');
select regexp_matches('a 1x1250x2500',
'(a|b).*?([1-9]\d*)\s*x\s*([1-9]\d*)(?:\s*x\s*([1-9]\d*))?');
