select
       daterange('[20231211', '20231211]')
       ,daterange('[20231211', '20231212)')
       ,daterange('20231211', '20231211', '[]')
       ,daterange('20231211', '20231212', '[)')
       ,'[20231211,20231211]'::daterange
       ,'[20231211,20231212)'::daterange
