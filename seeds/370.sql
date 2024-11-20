select '-NaN'::float union select ('Infinity'::float + '-Infinity') union select 'NaN';
set enable_hashagg =0;
select '-NaN'::float union select ('Infinity'::float + '-Infinity') union select 'NaN';
