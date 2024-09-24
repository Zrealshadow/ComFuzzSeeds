#include <pg_query.h>
#include <stdio.h>
#include <stdlib.h>

int main(int argc, char *argv[])
{

    PgQueryParseResult result;

    // result = pg_query_parse("SELECT ;");

    // result = pg_query_parse(
    //     "CREATE TABLE t (a integer) PARTITION BY RANGE (a);\nCREATE TABLE tp (a integer PRIMARY KEY);\nALTER TABLE t ATTACH PARTITION tp FOR VALUES FROM (0) TO (1000);\nCREATE UNIQUE INDEX t_a_idx ON t (a);\nALTER INDEX t_a_idx ATTACH PARTITION tp_pkey;\nALTER TABLE t DETACH PARTITION tp;");

    // char *msg = "-- Create table A\
    //     CREATE TABLE A;\
    // --Insert data from table B into table A\
    //     INSERT INTO A SELECT *FROM B;\
    // --Drop table B \
    //     DROP TABLE B; \
    // --Rename table A to table B \
    //     ALTER TABLE A RENAME TO B; \
    // --Insert into table A with a join \
    //       INSERT INTO A \
    //           SELECT X \
    //               FROM B AS DEST_TABLE \
    //               JOIN( \
    //                   SELECT CALC_METHOD AS S0, P_KEY AS S1, EXECUTION_NUMBER AS S2 FROM AW_001_000012_000001) AS SOURCE_TABLE \
    //                   ON SOURCE_TABLE.S0 = DEST_TABLE.CALC_METHOD \
    //                                            AND SOURCE_TABLE.S1 = DEST_TABLE.KEY_DIM; \
    // ";

    char *msg = "\
SELECT pid, state, now() - backend_start AS backend_age, now() - xact_start AS xact_age, now() - state_change AS state_age, query \
FROM pg_stat_activity \
WHERE state = 'idle in transaction' \
ORDER BY backend_start;\
";

    result = pg_query_parse(msg);

    if (result.error != NULL)
    {
        printf("error: %s\n", result.error->message);
        return 1;
    }
    else
    {
        printf("%s\n", result.parse_tree);
    }

    pg_query_free_parse_result(result);
}