SELECT DISTINCT TRIM(TRAILING FROM 'cnam_lpp_histo_io','_io') AS "A"
	,RTRIM('cnam_lpp_histo_io','_io') AS "B"
	,REPLACE('cnam_lpp_histo_io','_io','') AS "C"
	,REGEXP_REPLACE('cnam_lpp_histo_io','_io$','') AS "D";
