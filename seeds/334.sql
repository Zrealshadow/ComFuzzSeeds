SELECT 'a fat cat sat on a mat and ate a fat rat'::tsvector @@ 'cat & rat'::tsquery;
SELECT 'cat & rat'::tsquery @@  'a fat cat sat on a mat and ate a fat rat';
