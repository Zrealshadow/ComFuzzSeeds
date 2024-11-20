select to_tsvector('spanish', 'canción') @@ to_tsquery('spanish', 'cancion');
select to_tsvector('spanish', 'peluquería') @@ to_tsquery('spanish', 'peluqueria');
