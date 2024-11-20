SELECT ts_headline('English','This Commercial Bank does not have any Equity in Europe but European Commercial Bank does', 
                    phraseto_tsquery('English','European Commercial Bank')::tsquery);
SELECT phraseto_tsquery('English','European Commercial Bank');
