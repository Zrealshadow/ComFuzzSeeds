SELECT
unnest(xpath('//cname/aname/text()','<cname><aname><![CDATA[select
5]]></aname></cname>'::xml))
