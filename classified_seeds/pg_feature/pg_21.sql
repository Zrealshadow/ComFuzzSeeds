do $$
declare
	M1 char(10) := 'abc';
	M2 varchar(12);
begin
	M2 := concat('-',M1,'-');
	raise info '%', M2;
end;
$$;

do $$
declare
	M1 char(10) := 'abc';
	M2 varchar(12);
begin
	M2 := concat('-',substring(M1,1,4),'-');
	raise info '%', M2;
end;
$$;
