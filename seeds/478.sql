SELECT tc.table_name
  FROM
    information_schema.table_constraints AS tc
    JOIN information_schema.constraint_column_usage AS ccu
      ON ccu.constraint_name = tc.constraint_name
  WHERE constraint_type = 'FOREIGN KEY' AND ccu.table_name = 'our_table';
