SELECT 'a\bc' ~ '^[a\\b]*$';
SELECT 'a\b' ~ '^[a\\b]*$';
SELECT 'a\b' ~ '^[a\b]*$';
SELECT 'a\b' ~ '(?e)^[a\b]*$';
