select kcu.column_name as my_column, ccu.table_name as foreign_table, ccu.column_name as foreign_column
from information_schema.table_constraints AS tc
  join information_schema.key_column_usage AS kcu ON tc.constraint_name = kcu.constraint_name
  join information_schema.constraint_column_usage AS ccu ON ccu.constraint_name = tc.constraint_name
where constraint_type = 'FOREIGN KEY' AND tc.table_name='some_table';
