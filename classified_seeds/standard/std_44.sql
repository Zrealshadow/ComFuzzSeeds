select version();
WITH test AS ( SELECT array[1,2] AS intarr ) 
                 SELECT unnest(intarr) AS lot_id FROM test WHERE false;
select version();
WITH test AS ( SELECT array[1,2] AS intarr ) 
                 SELECT unnest(intarr) AS lot_id FROM test WHERE false;
with test as ( SELECT array[1,2] as intarr )
 SELECT unnest(intarr) as lot_id FROM test where now()<'1996-01-01';
