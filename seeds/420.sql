select
    unnest(proargnames[pronargs-pronargdefaults+1:pronargs] )optargnames,
    unnest(string_to_array(pg_get_expr(proargdefaults, 0)::text,','))
optargdefaults
from
    pg_catalog.pg_proc
where
    proname = 'proc name'
