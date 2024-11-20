DO language plpgsql
$$
DECLARE
 vara integer;
 varb integer;
 varc integer;
BEGIN
 SELECT 1, 2, 3 INTO vara, varb, varc;
 RAISE NOTICE '% % %', vara, varb, varc;
END;
$$;

DO language plpgsql
$$
DECLARE
 vara integer;
 varb integer;
 varc integer;
BEGIN
 SELECT 1, 2, 3 INTO vara, varb AS varc;
 RAISE NOTICE '% % %', vara, varb, varc;
END;
$$;
