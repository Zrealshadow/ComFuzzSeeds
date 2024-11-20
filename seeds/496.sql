SELECT to_tsvector('english', 'This is the rat.Fat is she!');
SELECT to_tsvector('english', 'This is the rat. Fat is she!');
SELECT to_tsvector('english', 'This is the rat.Fat is she!') @@ websearch_to_tsquery('fat');
SELECT to_tsvector('english', 'This is the rat. Fat is she!') @@ websearch_to_tsquery('fat');
