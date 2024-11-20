select now()::timestamp(0), now()::timestamp(0) with time zone,
timezone('utc', now()::timestamp(0)), timezone('utc', now()::timestamp(0)
with time zone);
show timezone;
