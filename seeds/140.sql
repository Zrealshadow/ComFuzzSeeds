SELECT name, setting FROM pg_settings WHERE category LIKE 'Write-Ahead Log%' OR category LIKE 'Replication%';
