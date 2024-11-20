select justify_interval(current_timestamp - current_timestamp + interval '8 year');
select justify_interval(current_timestamp - (current_timestamp - interval '8 year'));
