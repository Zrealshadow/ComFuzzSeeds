select to_tsquery('simple', 'thing.a:*');
select to_tsquery('simple', 'the.thing.a:*');
select to_tsquery('simple', 'the.thing.aa:*');
select to_tsquery('simple', 'the.thing@gmail.com');
select to_tsquery('simple', 'the.thing@gma:*');
