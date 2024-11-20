select ts_headline('baz baz baz ipsum ' || repeat(' foo ',4998) || ' labor', $$'ipsum' & 'labor'$$::tsquery, 'StartSel=>, StopSel=<, MaxFragments=100, MaxWords=7, MinWords=3') ;
select ts_headline('baz baz baz ipsum ' || repeat(' foo ',4999) || ' labor', $$'ipsum' & 'labor'$$::tsquery, 'StartSel=>, StopSel=<, MaxFragments=100, MaxWords=7, MinWords=3') ;
select ts_headline('baz baz baz ipsum ' || repeat(' foo ',4999) || ' labor', $$'ipsum' | 'labor'$$::tsquery, 'StartSel=>, StopSel=<, MaxFragments=100, MaxWords=7, MinWords=3') ;
select ts_headline('baz baz ipsum ' || repeat(' foo ',4999) || ' labor', $$'ipsum' & 'labor'$$::tsquery, 'StartSel=>, StopSel=<, MaxFragments=100, MaxWords=7, MinWords=3') ;
select ts_headline('baz baz ipsum ' || repeat(' foo ',4999) || ' labor', $$'ipsum' & 'labor'$$::tsquery, 'StartSel=>, StopSel=<, MaxFragments=100, MaxWords=7, MinWords=2') ;
