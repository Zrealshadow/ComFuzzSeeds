select current_setting( 'my.app_period', true ) is null;
begin;
select set_config( 'my.app_period', 'some value', true );
select current_setting( 'my.app_period', true ) is null;
select current_setting( 'my.app_period', true );
rollback;
select current_setting( 'my.app_period', true ) is null;
select current_setting( 'my.app_period', true ) is null;
select version();
