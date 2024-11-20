select regexp_replace('a(d)s(e)f', '\(.*?\)', '', 'g');
select regexp_replace('a(d)s(e)f', '\(.*?\)|q', '', 'g');
