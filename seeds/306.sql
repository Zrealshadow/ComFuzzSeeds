SELECT version();
SET idle_in_transaction_session_timeout=500;
BEGIN;
SELECT * FROM pg_class;
