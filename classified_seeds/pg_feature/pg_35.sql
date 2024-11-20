SELECT
             typ.oid AS typoid, nspname, relname, attname, attrelid, attnum, attnotnull,
             attidentity != '' AS isidentity,
             CASE WHEN typ.typtype = 'd' THEN typ.typtypmod ELSE atttypmod END AS typmod,
             CASE WHEN atthasdef THEN (SELECT pg_get_expr(adbin, cls.oid) FROM pg_attrdef WHERE adrelid = cls.oid AND adnum = attr.attnum) ELSE NULL END AS default,
             CASE WHEN col.is_updatable = 'YES' THEN true ELSE false END AS is_updatable,
             EXISTS (
               SELECT * FROM pg_index
               WHERE pg_index.indrelid = cls.oid AND
                     pg_index.indisprimary AND
                     attnum = ANY (indkey)
             ) AS isprimarykey,
             EXISTS (
               SELECT * FROM pg_index
               WHERE pg_index.indrelid = cls.oid AND
                     pg_index.indisunique AND
                     pg_index.indnkeyatts = 1 AND
                     attnum = pg_index.indkey[0]
             ) AS isunique
        FROM pg_attribute AS attr
        JOIN pg_type AS typ ON attr.atttypid = typ.oid
          JOIN pg_class AS cls ON cls.oid = attr.attrelid
        JOIN pg_namespace AS ns ON ns.oid = cls.relnamespace
        LEFT OUTER JOIN information_schema.columns AS col ON col.table_schema = nspname AND
             col.table_name = relname AND
             col.column_name = attname
        WHERE
             atttypid <> 0 AND
             relkind IN ('r', 'v', 'm') AND
             NOT attisdropped AND
             nspname NOT IN ('pg_catalog', 'information_schema') AND
             attnum > 0 AND
             ((attr.attrelid=1354075 AND attr.attnum=1))
ORDER BY attnum
