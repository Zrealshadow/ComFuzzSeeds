SELECT
   v.i,
   (SELECT random() from (values (v.i)) as q) AS v1
FROM
   generate_series(1, 2) as v(i);
