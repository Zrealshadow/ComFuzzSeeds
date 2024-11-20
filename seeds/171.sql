with t(x) as (values('1111-11-11 BC'::date)) select make_date(extract(year from x)::int, extract(month from x)::int, extract(day from x)::int) from t;
