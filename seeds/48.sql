SELECT (1,NULL) = (1,NULL);
CREATE TYPE pair AS (a int, b int);
SELECT (1,NULL)::pair = (1,NULL)::pair ;
