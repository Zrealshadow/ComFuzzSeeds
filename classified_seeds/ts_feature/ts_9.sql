select
  'Exact p = 1 microsecond' as "message",
  to_timestamp (extract (epoch from timestamptz '2022-08-01 00:00:00.000000 +00:00')) as "2022-08-01 00:00:00.000000",
  to_timestamp (extract (epoch from timestamptz '2022-08-01 00:00:00.000001 +00:00')) as "2022-08-01 00:00:00.000001",
  to_timestamp (extract (epoch from timestamptz '2022-08-01 00:00:00.000002 +00:00')) as "2022-08-01 00:00:00.000002",
  to_timestamp (extract (epoch from timestamptz '2022-08-01 00:00:00.000003 +00:00')) as "2022-08-01 00:00:00.000003" ;
select
  'Error p ~ 2 microseconds' as "message",
  to_timestamp (extract (epoch from timestamptz '2361-08-01 00:00:00.000000 +00:00')) as "2361-08-01 00:00:00.000000",
  to_timestamp (extract (epoch from timestamptz '2361-08-01 00:00:00.000001 +00:00')) as "2361-08-01 00:00:00.000001",
  to_timestamp (extract (epoch from timestamptz '2361-08-01 00:00:00.000002 +00:00')) as "2361-08-01 00:00:00.000002",
  to_timestamp (extract (epoch from timestamptz '2361-08-01 00:00:00.000003 +00:00')) as "2361-08-01 00:00:00.000003";
select
  'Error p ~ 4 microseconds' as "message",
  to_timestamp (extract (epoch from timestamptz '2713-08-01 00:00:00.000000 +00:00')) as "2713-08-01 00:00:00.000000",
  to_timestamp (extract (epoch from timestamptz '2713-08-01 00:00:00.000001 +00:00')) as "2713-08-01 00:00:00.000001",
  to_timestamp (extract (epoch from timestamptz '2713-08-01 00:00:00.000002 +00:00')) as "2713-08-01 00:00:00.000002",
  to_timestamp (extract (epoch from timestamptz '2713-08-01 00:00:00.000003 +00:00')) as "2713-08-01 00:00:00.000003";
select
  'Error p ~ 8 microseconds' as "message",
  to_timestamp (extract (epoch from timestamptz '4022-08-01 00:00:00.000000 +00:00')) as "4022-08-01 00:00:00.000000",
  to_timestamp (extract (epoch from timestamptz '4022-08-01 00:00:00.000010 +00:00')) as "4022-08-01 00:00:00.000010",
  to_timestamp (extract (epoch from timestamptz '4022-08-01 00:00:00.000020 +00:00')) as "4022-08-01 00:00:00.000020",
  to_timestamp (extract (epoch from timestamptz '4022-08-01 00:00:00.000030 +00:00')) as "4022-08-01 00:00:00.000030";
select
  'Error p ~ 32 microseconds' as "message",
  to_timestamp (extract (epoch from timestamptz '8022-08-01 00:00:00.000000')) as "8022-08-01 00:00:00.000000",
  to_timestamp (extract (epoch from timestamptz '8022-08-01 00:00:00.000010')) as "8022-08-01 00:00:00.000010",
  to_timestamp (extract (epoch from timestamptz '8022-08-01 00:00:00.000020')) as "8022-08-01 00:00:00.000020",
  to_timestamp (extract (epoch from timestamptz '8022-08-01 00:00:00.000030')) as "8022-08-01 00:00:00.000030";
