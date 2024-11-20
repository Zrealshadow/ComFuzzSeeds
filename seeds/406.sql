SELECT ts_headline('simple','The Cyberpunk launch did not go as expected for Cyberpunk Fans around the world', phraseto_tsquery('simple','Cyberpunk Fans')::tsquery);
SELECT phraseto_tsquery('simple','Cyberpunk Fans');
