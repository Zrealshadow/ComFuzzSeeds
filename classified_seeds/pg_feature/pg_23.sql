SELECT most_common_freqs[
    array_position(most_common_vals::text::text[],'range_ops'::text)
] * 100 AS occurrence_percent  
FROM pg_stats 
WHERE schemaname='pg_catalog' AND tablename ='pg_opfamily' AND attname=
'opfname';
