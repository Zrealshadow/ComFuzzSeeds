select (CASE WHEN pg_has_role(c.relowner, 'USAGE'::text) THEN pg_get_viewdef(c.oid) ELSE NULL::text END) as view_src from pg_class c where (c.relkind = 'v'::"char");
