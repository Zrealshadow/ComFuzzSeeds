SELECT * FROM pg_create_physical_replication_slot('sam_repli_3');
select version ();
select * from pg_replication_slots;
