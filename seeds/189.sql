do language plpgsql $$
declare
  v_text text := 'a';
begin
  for i in 1..290000 loop
    execute $_$select pg_create_logical_replication_slot('logical_slot4', 'test_decoding')$_$;
    execute $_$select pg_drop_replication_slot('logical_slot4')$_$;
  end loop;
exception when others then
  raise notice 'execute  failed.';
end;$$;
