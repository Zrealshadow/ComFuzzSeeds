SELECT n.tableoid, n.oid, n.nspname,
(SELECT rolname FROM pg_catalog.pg_roles WHERE oid = nspowner) AS rolname,
(SELECT pg_catalog.array_agg(acl) FROM (SELECT
pg_catalog.unnest(coalesce(n.nspacl,pg_catalog.acldefault('n',n.nspowner)))
AS acl EXCEPT SELECT
pg_catalog.unnest(coalesce(pip.initprivs,pg_catalog.acldefault('n',n.nspowner))))
as foo) as nspacl, (SELECT pg_catalog.array_agg(acl) FROM (SELECT
pg_catalog.unnest(coalesce(pip.initprivs,pg_catalog.acldefault('n',n.nspowner)))
AS acl EXCEPT SELECT
pg_catalog.unnest(coalesce(n.nspacl,pg_catalog.acldefault('n',n.nspowner))))
as foo) as rnspacl, NULL as initnspacl, NULL as initrnspacl FROM
pg_namespace n LEFT JOIN pg_init_privs pip ON (n.oid = pip.objoid AND
pip.classoid = 'pg_namespace'::regclass AND pip.objsubid = 0 AND pip.objoid
<> 'public'::regnamespace);
