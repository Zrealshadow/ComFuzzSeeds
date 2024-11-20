do $sql$
declare _n int; _s text;
begin
   select 1, 'string1', 'string2'
   into _n _s;
   
   raise notice '_n = %, _s = %', _n, _s;
end;
$sql$;
