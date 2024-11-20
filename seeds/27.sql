select relname, relfrozenxid from pg_class where relname like '%_mv' or relname = 'user_agents_canonical_user_agent_os';
