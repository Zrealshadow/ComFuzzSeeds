CREATE OR REPLACE FUNCTION keep_any_ddl_command() RETURNS event_trigger
    LANGUAGE plpgsql
    AS $$
    BEGIN
        SELECT classid, objid, objsubid FROM pg_event_trigger_ddl_commands();

        -- some insert code;
    END;
$$;

CREATE TABLE ddl_events();

CREATE EVENT TRIGGER keep_all_ddl ON ddl_command_end
   EXECUTE PROCEDURE keep_any_ddl_command();
