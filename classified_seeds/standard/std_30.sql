SELECT * FROM (VALUES (1, 'microsoft', 'microsoft.png', now(), now()), (2, 'azure', 'azure.png', now(), now())) as t(id, name, image, created, modified);
