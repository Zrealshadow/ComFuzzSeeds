SELECT x, '|'||substring(x, '(\S.*\S)')||'|'
FROM (VALUES (' a'), (' ab'), ('  a b c '), (E' c\n'), (E' ab\n')) AS z (x);
