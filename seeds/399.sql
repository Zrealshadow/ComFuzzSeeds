SELECT '2003-03-30 02:59:59'::timestamp without time zone < '2003-03-30 03:00:00'::timestamp without time zone;
SELECT '2003-03-30 02:59:59'::timestamp with time zone < '2003-03-30 03:00:00'::timestamp with time zone;
SELECT tstzrange('2003-03-30 02:59:59', '2003-03-30 03:00:00');
SELECT '2003-03-30 01:59:59'::timestamp with time zone;
SELECT '2003-03-30 02:00:00'::timestamp with time zone;
SELECT '2003-03-30 02:59:59'::timestamp with time zone;
SELECT '2003-03-30 03:00:00'::timestamp with time zone;
