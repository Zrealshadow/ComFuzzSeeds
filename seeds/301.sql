select version();
select ((xpath('/*',xml('<root><a/><b/><c/></root>')))[1])::text;
select ((xpath('/*',xml('<root><a/><b/><c/>one value</root>')))[1])::text;
