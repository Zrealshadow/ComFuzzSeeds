import re
import argparse
import json
import os
import logging

# Only check if there is keywords in the text
# PostgreSQL Version 12
# keywords docs https://www.postgresql.org/docs/12/sql-commands.html
# exclude the DO / MOVE /

key_words_path = './postgres_keywords.txt'
sql_keywords = []
with open(key_words_path, 'r', encoding='utf-8') as f:
    for i in f.readlines():
        sql_keywords.append(i.strip().replace("\n", ""))
    print(f"successfully loading postgres Keywords from file {key_words_path}")

# sql_keywords = ["ABORT", "ALTER AGGREGATE", "ALTER COLLATION", "ALTER CONVERSION", "ALTER DATABASE", "ALTER DEFAULT PRIVILEGES", "ALTER DOMAIN", "ALTER EVENT TRIGGER", "ALTER EXTENSION", "ALTER FOREIGN DATA WRAPPER", "ALTER FUNCTION", "ALTER GROUP", "ALTER INDEX", "ALTER LANGUAGE", "ALTER LARGE OBJECT", "ALTER MATERIALIZED VIEW", "ALTER OPERATOR", "ALTER OPERATOR CLASS", "ALTER OPERATOR FAMILY", "ALTER POLICY", "ALTER PROCEDURE", "ALTER ROLE", "ALTER ROUTINE", "ALTER RULE", "ALTER SCHEMA", "ALTER SEQUENCE", "ALTER SERVER", "ALTER STATISTICS", "ALTER SUBSCRIPTION", "ALTER SYSTEM", "ALTER TABLE", "ALTER TABLESPACE", "ALTER TEXT SEARCH CONFIGURATION", "ALTER TEXT SEARCH DICTIONARY", "ALTER TEXT SEARCH PARSER", "ALTER TEXT SEARCH TEMPLATE", "ALTER TRIGGER", "ALTER TYPE", "ALTER USER", "ALTER USER MAPPING", "ALTER VIEW", "ANALYZE", "BEGIN", "CALL", "CHECKPOINT", "CLOSE", "COMMENT", "COMMIT", "COMMIT PREPARED", "COPY", "CREATE ACCESS METHOD", "CREATE AGGREGATE", "CREATE CAST", "CREATE COLLATION", "CREATE CONVERSION", "CREATE DATABASE", "CREATE DOMAIN", "CREATE EVENT TRIGGER", "CREATE EXTENSION", "CREATE FOREIGN DATA WRAPPER", "CREATE FOREIGN TABLE", "CREATE FUNCTION", "CREATE GROUP", "CREATE INDEX", "CREATE LANGUAGE", "CREATE MATERIALIZED VIEW", "CREATE OPERATOR", "CREATE OPERATOR CLASS", "CREATE OPERATOR FAMILY", "CREATE POLICY", "CREATE PROCEDURE", "CREATE PUBLICATION", "CREATE ROLE", "CREATE RULE", "CREATE SCHEMA", "CREATE SEQUENCE", "CREATE SERVER", "CREATE STATISTICS", "CREATE SUBSCRIPTION", "CREATE TABLE", "CREATE TABLE AS", "CREATE TABLESPACE", "CREATE TEXT SEARCH CONFIGURATION",
#                 "CREATE TEXT SEARCH DICTIONARY", "CREATE TEXT SEARCH PARSER", "CREATE TEXT SEARCH TEMPLATE", "CREATE TRANSFORM", "CREATE TRIGGER", "CREATE TYPE", "CREATE USER", "CREATE USER MAPPING", "CREATE VIEW", "DEALLOCATE", "DECLARE", "DELETE", "DISCARD", "DROP ACCEWSS METHOD", "DROP AGGREGATE", "DROP CAST", "DROP COLLATION", "DROP CONVERSION", "DROP DATABASE", "DROP DOMAIN", "DROP EVENT TRIGGER", "DROP EXTENSION", "DROP FOREIGN DATA WRAPPER", "DROP FOREIGN TABLE", "DROP FUNCTION", "DROP GROUP", "DROP INDEX", "DROP LANGUAGE", "DROP MATERIALIZED VIEW", "DROP OPERATOR", "DROP OPERATOR CLASS", "DROP OPERATOR FAMILY", "DROP OWNED", "DROP POLICY", "DROP PROCEDURE", "DROP PUBLICATION", "DROP ROLE", "DROP ROUTINE", "DROP RULE", "DROP SCHEMA", "DROP SEQUENCE", "DROP SERVER", "DROP STATISTICS", "DROP SUBSCRIPTION", "DROP TABLE", "DROP TABLESPACE", "DROP TEXT SEARCH CONFIGURATION", "DROP TEXT SEARCH DICTIONARY", "DROP TEXT SEARCH PARSER", "DROP TEXT SEARCH TEMPLATE", "DROP TRANSFORM", "DROP TRIGGER", "DROP TYPE", "DROP USER", "DROP USER MAPPING", "DROP VIEW", "EXECUTE", "EXPLAIN", "FETCH", "GRANT", "IMPORT FOREIGN SCHEMA", "INSERT", "LISTEN", "LOAD", "LOCK", "MOVE", "NOTIFY", "PREPARE", "PREPARE TRANSACTION", "REASSIGN OWNED", "REFRESH MATERIALIZED VIEW", "REINDEX", "RELEASE SAVEPOINT", "RESET", "REVOKE", "ROLLBACK", "ROLLBACK PREPARED", "ROLLBACK TO SAVEPOINT", "SAVEPOINT", "SECURITY LABEL", "SELECT", "SELECT INTO", "SET", "SET CONSTRAINTS", "SET ROLE", "SET SESSION AUTHORIZATION", "SET TRANSACTION", "SHOW", "START TRANSACTION", "TRUNCATE", "UNLISTEN", "UPDATE", "VACUUM", "VALUES"]

# sub_sql_regex = r'"b(?:CREATE TABLE,"ALTER TABLE,"SELECT,"DROP TABLE,"UPDATE,"BEGIN TRANSACTION,"COMMIT)"b'
# sql_pattern = re.compile(sub_sql_regex, re.IGNORECASE)
sql_regex = r"\b(?:{})\b".format("|".join(sql_keywords))
sql_pattern = re.compile(sql_regex, re.IGNORECASE)


def test():
    test_cases = [
        "CREATE TABLE users (id SERIAL PRIMARY KEY, name TEXT);",
        "ALTER TABLE users ADD COLUMN age INT;",
        "SELECT * FROM users;",
        "DROP TABLE users;",
        "UPDATE users SET name = 'John' WHERE id = 1;",
        "BEGIN TRANSACTION; COMMIT;",
        "This is a non-SQL statement.",
        "EXECUTE some_procedure();",
        "Some random text with no SQL commands."
    ]

    for i, case in enumerate(test_cases):
        match = sql_pattern.findall(case)
        if match:
            print(f"Test case {i} contains SQL commands {match}.")
        else:
            print(f"Test case {i} does not contain SQL commands.")


parser = argparse.ArgumentParser(
    description="this script is to filter out the email text which contains SQL keywords command \n\
        relieve the workload of subsequent processing"
)

parser.add_argument(
    '-t', '--test',
    action='store_true',
    help='Run the test cases'
)

parser.add_argument(
    '-d', '--dir',
    type=str,
    default="",
    help="path to the directory containing the email text files"
)

parser.add_argument(
    '-f', '--file',
    type=str,
    default="",
    help="path to the email text file"
)

parser.add_argument(
    '-o', '--output',
    type=str,
    default="",
    help="path to save the filtered email text file"
)

parser.add_argument(
    '-v', '--verbose',
    action='store_true',
    help='Whether to print the progress'
)

parser.add_argument(
    '-r', '--report',
    action='store_true',
    help='Whether to print the report'
)

args = parser.parse_args()

logging.basicConfig(level=logging.DEBUG if args.verbose else logging.INFO,
                    format='%(asctime)s - %(name)s - %(levelname)s - %(message)s')
LOGGER = logging.getLogger(__name__)

if args.report:
    file_handler = logging.FileHandler('./tmp/filter/report.txt', mode = 'w')
    file_handler.setLevel(logging.INFO)
    formatter = logging.Formatter(
        '%(asctime)s - %(name)s - %(levelname)s - %(message)s')
    file_handler.setFormatter(formatter)
    LOGGER.addHandler(file_handler)


def email_text_contain_sql_keywords(text):
    match = sql_pattern.findall(text)
    flag = True if match else False
    return flag, match


def filter_text_in_file(file_path: str) -> dict:
    mbox_msg_dict = {}
    res_mbox_msg_dict = {}
    with open(file_path, 'r', encoding='utf-8') as f:
        mbox_msg_dict = json.load(f)

    for msg_id, msg in mbox_msg_dict.items():
        msg_text = msg['text']
        f, _ = email_text_contain_sql_keywords(msg_text)
        if f:
            res_mbox_msg_dict[msg_id] = msg

    LOGGER.info(f"------------ Report for file {file_path} ------------")
    LOGGER.info(f"Total number of messages: {len(mbox_msg_dict)}")
    LOGGER.info(
        f"Number of messages containing SQL keywords: {len(res_mbox_msg_dict)} / {len(mbox_msg_dict)}")

    return res_mbox_msg_dict


if __name__ == '__main__':

    if args.test:
        test()
        exit(0)

    if (args.file == "" and args.dir == "") or (args.file != "" and args.dir != ""):
        LOGGER.error("Please specify either the file or the directory.")
        exit(1)

    res_mbox_msg_dict = {}

    if args.file != "":
        LOGGER.info(f"Filtering the email text in file {args.file}")

        # check file exist
        if not os.path.exists(args.file):
            LOGGER.error(f"File {args.file} does not exist.")
            exit(1)

        filter_text_in_file(args.file)

    if args.dir != "":

        if not os.path.isdir(args.dir):
            LOGGER.error(f"Directory {args.dir} does not exist.")
            exit(1)

        file_paths = [os.path.join(args.dir, file)
                      for file in os.listdir(args.dir)]

        LOGGER.info(
            f"Filtering the email text in directory {args.dir}, containing {len(file_paths)} files.")

        tmp_dict = {}
        for idx, fp in enumerate(file_paths):
            tmp_dict = filter_text_in_file(fp)
            res_mbox_msg_dict.update(tmp_dict)

    if args.output != "":
        try:
            with open(args.output, 'w') as f:
                json.dump(res_mbox_msg_dict, f)
            LOGGER.info(f"Successfully saved the filtered email message to {args.output}, containing {len(res_mbox_msg_dict)} messages.")
        except Exception as e:
            LOGGER.error(f"Error in saving the filtered email text: {e}")
            exit(1)
