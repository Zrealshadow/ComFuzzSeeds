SELECT table_name, table_schema from information_schema.tables 
WHERE table_schema = 'your schema' AND table_type LIKE 'BASE TABLE' ORDER BY
table_name;
