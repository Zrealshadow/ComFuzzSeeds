SELECT
   a,
   b.p,
   c.p
FROM
  (VALUES (1)) a
  JOIN LATERAL (
    SELECT p FROM (VALUES (2)) p
  ) b ON TRUE
  JOIN LATERAL (
    SELECT p FROM (VALUES (3)) p
  ) c ON TRUE
;

SELECT
   a,
   b.a
FROM
  (VALUES (1)) a
  JOIN (
    SELECT a FROM (VALUES (2)) a
  ) b ON TRUE
;

SELECT
   a,
   b.a
FROM
  (VALUES (1)) a
  JOIN (
    SELECT 2 AS a
  ) b ON TRUE
;
