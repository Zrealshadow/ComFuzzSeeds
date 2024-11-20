select 'TextToMatch' like any (array[E'Te\%tch', E'nomatch']); -- true, correct
select 'TextToMatch' NOT like any (array[E'Te\%tch', E'nomatch']); -- true but must be false because it's a negated version of the expression above
select 'TextToMatch' like any (array['Te\%tch', 'nomatch']); -- false
select 'TextToMatch' NOT like any (array['Te\%tch', 'nomatch']); -- true
