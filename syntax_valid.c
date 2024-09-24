#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <assert.h>
#include <stdarg.h>

#include <cJSON.h>
#include <pg_query.h>

char *read_file(const char *filename)
{
    FILE *file = fopen(filename, "r");
    if (!file)
    {
        printf("Error opening file: %s\n", filename);
        return NULL;
    }

    fseek(file, 0, SEEK_END);
    long length = ftell(file);
    fseek(file, 0, SEEK_SET);

    char *content = malloc(length + 1);
    if (content)
    {
        fread(content, 1, length, file);
        content[length] = '\0'; // Null-terminate the string
    }

    fclose(file);
    return content;
}

void print_to_report(FILE *report_file, const char *format, ...)
{
    va_list args;
    va_start(args, format);
    vfprintf(stderr, format, args);
    va_end(args);

    if (report_file)
    {
        va_start(args, format);
        vfprintf(report_file, format, args);
        va_end(args);
    }
}

int main(int argc, char *argv[])
{
    FILE *report_file = NULL;
    FILE *output_file = NULL;

    if (argc == 1)
    {
        // print helper function
        fprintf(stderr, "Usage: %s <json_file> <output_file> [report_file]\n", argv[0]);
        // explain each arguments
        fprintf(stderr, "Arguments:\n");
        fprintf(stderr, "  <json_file>         - JSON file containing SQL statements\n");
        fprintf(stderr, "  <output_file>       - JSON file containing the flawed msg_id and error hint \n");
        fprintf(stderr, "  [report_file]       - Optional file to write the report\n");
        return 1;
    }

    if (argc < 3 || argc > 4)
    {
        fprintf(stderr, "Usage: %s <json_file> <output_json_file> [report_file]\n", argv[0]);
        return 1;
    }
    // If a report file is provided, open it for writing

    if (argc == 4)
    {
        report_file = fopen(argv[3], "w");
        if (!report_file)
        {
            fprintf(stderr, "Error opening report file: %s\n", argv[3]);
            return 1;
        }
    }

    char *output_filepath = argv[2];
    output_file = fopen(output_filepath, "w");
    if (!output_file)
    {
        fprintf(stderr, "Error opening output file: %s\n", output_filepath);
        if (report_file)
            fclose(report_file);
        return 1;
    }

    char *json_content = read_file(argv[1]);

    if (!json_content)
    {
        if (report_file)
            fclose(report_file);
        return 1;
    }

    // Parse JSON
    cJSON *json = cJSON_Parse(json_content);
    if (!json)
    {
        fprintf(stderr, "Error parsing JSON: %s\n", cJSON_GetErrorPtr());
        free(json_content);
        if (report_file)
            fclose(report_file);
        return 1;
    }

    assert(cJSON_IsObject(json));

    int n = cJSON_GetArraySize(json);
    print_to_report(report_file, "------------ Report for syntax checking parsed  %s --------------\n", argv[1]);
    print_to_report(report_file, "==> Number of items in array: %d\n", n);

    cJSON *current = NULL;

    PgQueryParseResult result;
    int cnt = 0;
    int err_cnt = 0;

    cJSON *output_json = cJSON_CreateObject();

    // enumerate all tems and check the syntax
    cJSON_ArrayForEach(current, json)
    {

        cnt++;
        if (cJSON_IsObject(current))
        {
            cJSON *sql_element = cJSON_GetObjectItem(current, "sql");
            assert(cJSON_IsString(sql_element));
            result = pg_query_parse(sql_element->valuestring);
        }
        else if (cJSON_IsString(current))
        {
            result = pg_query_parse(current->valuestring);
        }
        else
        {
            fprintf(stderr, "Invalid JSON format\n");
            return 1;
        }

        if (result.error != NULL)
        {
            char *key = current->string;
            // write to output json file
            cJSON_AddStringToObject(output_json, key, result.error->message);
            err_cnt++;
            char *msg = result.error->message;

            fprintf(report_file, "==> error in %d msg: %s\n", cnt, result.error->message);
        }
    }

    print_to_report(report_file, "Total broken SQL statements: %d / %d\n", err_cnt, cnt);

    // write output json to output_file
    char *json_string = cJSON_Print(output_json);
    if (!json_string)
    {
        fprintf(stderr, "Error printing JSON\n");
        return 1;
    }

    fprintf(output_file, "%s", json_string);

    fclose(output_file);
    fclose(report_file);
    // free the used memory
    cJSON_Delete(output_json);
    cJSON_Delete(json);
    free(json_content);
    pg_query_free_parse_result(result);
}