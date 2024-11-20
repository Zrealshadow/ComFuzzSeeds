SELECT
	x.table_schema as schema_name,
	c.constraint_name as constraint_name,
	x.table_name as table_name,
	x.column_name as column_name,
	y.table_name as referenced_table_name,
	y.column_name as referenced_column_name,
	y.ordinal_position as ordinal_position
FROM information_schema.referential_constraints c
JOIN information_schema.key_column_usage x ON (x.constraint_name =
c.constraint_name)
JOIN information_schema.key_column_usage y ON (y.ordinal_position =
x.position_in_unique_constraint AND y.constraint_name =
c.unique_constraint_name)
WHERE LOWER(y.table_name) = LOWER('PUT_TABLE_NAME_HERE')
ORDER BY x.table_name, c.constraint_name, x.ordinal_position;
