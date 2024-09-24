"""
Utilize the Large Language Model to fix the SQL queries with flaws syntax flaws.
"""

import os
import json

from openai import OpenAI


key_path = "./key.txt"
api_key = ""

with open(key_path, "r", encoding="utf-8") as f:
    api_key = f.readlines()[0].strip()

if api_key == "":
    print("Please add your API key to the key.txt file")

base_url = "https://api.deepseek.com"
client = OpenAI(api_key=api_key, base_url=base_url)


content = """
Task: fix the SQL syntax error in given sql queries according to the error hint.
maybe you have to removed the unrelaed characters and fix the broken Postgres sql queries to obey the syntax rules. 
Task input is a dict contain two keys, sql and error_hint. sql is a sql queries with syntax error. 
Task output is the fixed sql queries;

For example:
input = {
        "sql": "create table a(id int);\nCREATE TABLE\ncreate table b(id int);\nCREATE TABLE\nbegin;\nBEGIN\ncopy a from stdin;\ncreate index idx_b_1 on b (id);\nCREATE INDEX\ncreate index CONCURRENTLY idx_b_2 on b (id);\nselect * from pg_locks where granted is not true;\nselect * from pg_locks where virtualxid='3/171';\nselect * from pg_stat_activity where pid=55384;",
        "error_hint": "syntax error at or near \"create\""
    }
output = "CREATE TABLE a(id int);\
CREATE TABLE b(id int);\
BEGIN;\
COPY a FROM stdin;\
CREATE INDEX idx_b_1 ON b (id);\
CREATE INDEX CONCURRENTLY idx_b_2 ON b (id);\
SELECT * FROM pg_locks WHERE granted IS NOT TRUE;\
SELECT * FROM pg_locks WHERE virtualxid = '3/171';\
SELECT * FROM pg_stat_activity WHERE pid = 55384;\
COMMIT;"

If the input sql queries are not be considered as Postgres sql, return empty string.

For example:
input = {
        "sql": "$ createdb --template=template0 test\n$ psql -c '\\dn+' test\n$ pg_dump -Fc -f test.dump test\n$ pg_restore -c -d test test.dump\n$ psql -c '\\dn+' test\n$ createdb --template=template0 test\n$ pg_dump -Fc -c -f test.dump\n$ pg_restore -c -d test test.dump\n$ psql -c '\\dn+' test",
        "error_hint": "syntax error at or near \"$\""
},
output = "" because the input text in sql are not be considered as Postgres sql.

Now I will give you the input, plz give me the output string.
"""

prompt = [
    {
        "role": "system",
        "content": "You are a helpful postgres query syntax fixer"
    },
    {
        "role": "user",
        "content": content
    }
]


# first positive example
first_round_question = """
input = {
        "sql": "update table1 set history=\u2018{}\u2019;\nupdate table1 set history=jsonb_set(history,\u2019{q1}\u2019, \u2018{}\u2019);\nupdate table1 set history=jsonb_set(history,\u2019{q1,obs}\u2019, to_jsonb(obs));",
        "error_hint": "syntax error at or near \"{\""
}
"""

first_round_answer = """
UPDATE table1 SET history = '\{\}'; 
UPDATE table1 SET history = jsonb_set(history, '\{q1\}', '\{\}');
UPDATE table1 SET history = jsonb_set(history, '\{q1,obs\}', to_jsonb(obs));
"""

first_round_QA = [
    {
        "role": "user",
        "content": first_round_question
    },
    {
        "role": "assistant",
        "content": first_round_answer
    }
]

prompt += first_round_QA


# second negative example
second_round_question = """
{
        "sql": "The raw text does not contain any SQL query snippets. Therefore, the output is:\n\n```",
        "error_hint": "syntax error at or near \"The\""
}
"""
second_round_answer = ""

second_round_QA = [
    {
        "role": "user",
        "content": second_round_question
    },
    {
        "role": "assistant",
        "content": second_round_answer
    }
]

prompt += second_round_QA


path = "./tmp/raw/flaw_sqls.json"
with open(path, 'r') as f:
    flaw_sqls = json.load(f)
print(f"==> Load all flawed SQL queries {len(flaw_sqls)}")


def remove_sql_prefix_suffix(text):
    # Remove the ```sql prefix and ``` suffix
    text = text.strip()
    if text.startswith('```sql') and text.endswith('```'):
        # Remove the prefix and suffix
        text = text[6:-3]

    return text.strip('`').strip()


# msg_id -> sql
ans = {}
n = len(flaw_sqls)
cnt = 0
for msg_id, val in flaw_sqls.items():
    content = str(val)
    cnt += 1
    msgs = prompt + [{
        "role": "user",
        "content": content
    }]
    try:
        response = client.chat.completions.create(
            model="deepseek-chat",
            messages=msgs,
            temperature=1.0,
        )
        text = response.choices[0].message.content
        text = remove_sql_prefix_suffix(text)
        if text == "" or text == "\"\"":
            print(
                f"==> [{cnt} / {n}] No SQL query found in the {msg_id}-th message")
        else:
            ans[msg_id] = text
            print(f"==> [{cnt} / {n}]  Success: {msg_id}")
    except Exception as e:
        print(f"==> [{cnt} / {n}] Error: {e}")
        continue


file_path = "./tmp/raw/fixed_flaw_sqls.json"
with open(file_path, 'w') as f:
    json.dump(ans, f)
print(f"==> Save the fixed SQL queries to {file_path}")
