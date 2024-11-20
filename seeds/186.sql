SELECT
   ROW() IS NULL,     -- true
   ROW() IS NOT NULL; -- true

SELECT
   ROW(NULL, NULL) IS NULL,     -- returns: true  (expected)
   ROW(NULL, NULL) IS NOT NULL, -- returns: false (expected)
   ROW(1, NULL) IS NULL,        -- returns: false (expected)
   ROW(1, NULL) IS NOT NULL,    -- returns: false !!
   ROW(1, 1) IS NULL,           -- returns: false (expected)
   ROW(1, 1) IS NOT NULL;       -- returns: true  (expected)
