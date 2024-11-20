select regexp_replace('Nigel DeFreit a  s', E'[\s+|"]|[\n\r\f\a\t]|[^[:ascii:]]','','g') AS result;
