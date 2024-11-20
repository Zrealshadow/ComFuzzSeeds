SELECT
        (web_query_and @@ ts_title)::INTEGER AS full_title_entries, -- 0 / supposed 1
        (web_query_and @@ '      ?')::INTEGER AS full_title_entries2,
        *
FROM 
        (SELECT 
                to_tsvector('russian', STRIP(to_tsvector('russian', '      ?'))::TEXT ) AS ts_title,
                websearch_to_tsquery('russian', REPLACE('      ?', '- ' , '')) AS web_query_and
                
        ) AS main
