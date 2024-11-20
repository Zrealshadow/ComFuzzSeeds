SELECT to_char(-(3 * 60 * 60 * 1000 + 7*60 * 1000 + 12345) * INTERVAL '1 millisecond', 'HH24:MI:SS.MS') as interv;
