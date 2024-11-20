BEGIN;
CREATE USER regress_priv_user8;
SET SESSION AUTHORIZATION regress_priv_user8;
SET LOCAL debug_parallel_query = 1;
