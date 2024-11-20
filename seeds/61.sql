select substring(cast(' 2345           ' as character(16)), 1, 7) || '?',
	substring(cast(' 2345           ' as varchar(16)), 1, 7) || '?';
