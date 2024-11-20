SELECT
FROM pg_catalog.pg_statio_all_tables AS ref_0,
     LATERAL (SELECT
              WHERE ref_0.schemaname = ref_0.relname) AS subq_0;
