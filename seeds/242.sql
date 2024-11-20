select ts_headline(
    $$Lorem ipsum urna.  Nullam  nullam ullamcorper urna.$$,
    to_tsquery('Lorem') && phraseto_tsquery('ullamcorper urna'),
    'StartSel=#$#, StopSel=#$#, FragmentDelimiter=$#$, MaxFragments=100,
MaxWords=100, MinWords=1'
);
