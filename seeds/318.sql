SELECT classid, objid, refclassid, refobjid, deptype FROM pg_depend WHERE deptype != 'p' AND deptype != 'e'
UNION ALL
SELECT 'pg_opfamily'::regclass AS classid, amopfamily AS objid, refclassid, refobjid, deptype FROM pg_depend d, pg_amop o WHERE deptype NOT IN ('p', 'e', 'i') AND classid = 'pg_amop'::regclass AND objid = o.oid AND NOT (refclassid = 'pg_opfamily'::regclass AND amopfamily = refobjid)
UNION ALL
SELECT 'pg_opfamily'::regclass AS classid, amprocfamily AS objid, refclassid, refobjid, deptype FROM pg_depend d, pg_amproc p WHERE deptype NOT IN ('p', 'e', 'i') AND classid = 'pg_amproc'::regclass AND objid = p.oid AND NOT (refclassid = 'pg_opfamily'::regclass AND amprocfamily = refobjid)
ORDER BY 1,2
