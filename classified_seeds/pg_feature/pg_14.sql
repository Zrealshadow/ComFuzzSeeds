create temp table aaa (id int, val1 text);

do language plpgsql $$
declare
	error_message			text;
	error_detailed_message	text;
	error_context			text;
	arr_test				aaa[];
begin
	--arr_test = (select row(id, val1) from aaa);		-- No error, correct call
	arr_test = (select id, val1 from aaa);			-- Error 42601 syntax_error 
exception
	--when syntax_error then
	when others then
		get stacked diagnostics
			error_message = message_text
            ,error_context = pg_exception_context
			,error_detailed_message = pg_exception_detail;

		raise notice 'message_text = %', error_message;
		raise notice 'pg_exception_context = %', error_context;
        raise notice 'pg_exception_detail = %', error_detailed_message;
end
$$;

drop table if exists aaa;
