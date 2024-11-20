select
    upper_inf('["2019-01-01",]'::daterange) as upper_null,
    upper_inf('["2019-01-01","2019-01-02"]'::daterange) as upper_valid,
    upper_inf('["2019-01-01",infinity]'::daterange) as upper_infinity;

select
    isfinite(upper('["2019-01-01",]'::daterange)) as upper_null,
    isfinite(upper('["2019-01-01","2019-01-02"]'::daterange)) as upper_valid,
    isfinite(upper('["2019-01-01",infinity]'::daterange)) as upper_infinity;
