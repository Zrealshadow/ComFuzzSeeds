with tbase(id)
as (select 1 union all select 2)
select id otto from tbase
group by otto
order by otto
