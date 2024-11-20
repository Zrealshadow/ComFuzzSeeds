UPDATE pg_database
SET datcollate = 'tr-TR.1254'
WHERE datcollate = 'Turkish_Turkey.1254';

UPDATE pg_database
SET datctype = 'tr-TR.1254'
WHERE datctype = 'Turkish_Turkey.1254';
