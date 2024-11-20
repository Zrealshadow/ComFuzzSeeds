select tc.table_schema, tc.table_name, 
       tc.constraint_type,tc.constraint_name, tc.is_deferrable,
       tc2.table_name as child_table,
       rc.unique_constraint_name as refer_key,
       case when rc.unique_constraint_name is not null then
            (select tc1.table_name 
               from information_schema.table_constraints tc1
              where tc1.constraint_name = rc.unique_constraint_name)
       end as ref_table,
       cc.check_clause,
       kc.column_name,
       kc.ordinal_position
  from information_schema.table_constraints tc
  left join information_schema.referential_constraints rc
    on tc.constraint_name = rc.constraint_name
  left join information_schema.check_constraints cc
    on tc.constraint_name = cc.constraint_name
  left join information_schema.key_column_usage kc
    on tc.constraint_name = kc.constraint_name
  left join LATERAL (
       select tc2.table_name, rc1.unique_constraint_name 
              from information_schema.referential_constraints rc1
              join information_schema.table_constraints tc2
                on rc1.constraint_name = tc2.constraint_name 
             where tc.constraint_name = rc1.unique_constraint_name
             ) tc2 on true
 where tc.table_name = 't1';
