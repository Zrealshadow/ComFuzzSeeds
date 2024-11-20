select current_setting('custom.a', true), current_setting('custom.a', true) is null;
BEGIN;
select set_config('custom.a', 'vv', true);
COMMIT;
select current_setting('custom.a', true), current_setting('custom.a', true) is null;
