WITH table1 AS ( SELECT 1 ) SELECT 1 FROM ( SELECT RANK ( ) OVER ( ) column0 FROM table1 JOIN table1 AS alias0 ON TRUE ) AS alias1 WHERE ( CASE WHEN ( 1 IN ( SELECT 1 ) ) THEN 1 END = column0 ) ;
