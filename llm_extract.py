import os
import json
from openai import OpenAI

key_path = "./key.txt"
api_key = ""

if not os.path.exists(key_path):
    print("API key found, plz save your LLM api key in key.txt under the workspace directory")

with open(key_path, "r", encoding="utf-8") as f:
    api_key = f.readlines()[0].strip()


filtered_pgmailing_msgs = "./tmp/filter/pgsql-bugs-msgs.json"

if not os.path.exists(filtered_pgmailing_msgs):
    print("Filtered pgsql mailing list messages not found, plz run the filter script first")

pgmailing_msgs = []
with open(filtered_pgmailing_msgs, "r", encoding="utf-8") as f:
    pgmailing_msgs = json.load(f)


# check existing raw sqls
raw_sqls_dir_path = "./tmp/raw/sqls"
raw_sqls_record_path = "./tmp/raw/record.json"
exist_msg_id_pool = {}

if not os.path.exists(raw_sqls_dir_path):
    os.mkdir(raw_sqls_dir_path)
    print(f"==> Created the raw sqls directory: {raw_sqls_dir_path}")

if os.path.exists(raw_sqls_record_path):
    with open(raw_sqls_record_path, "r", encoding="utf-8") as f:
        # for idx, line in enumerate(f.readlines()):
        #     msg_id = line.strip()
        #     exist_msg_id_pool[msg_id] = idx + 1
        exist_msg_id_pool = json.load(f)

processed_msg_num = len(exist_msg_id_pool)

if processed_msg_num != 0:
    print(f"==> Found {processed_msg_num} existing msgs are processed")


# construct the prompt

raw_text = """
I discussed it in local telegram PSQL community

insert into tst_t1 (id, name) values (1, 'T1');
insert into tst_a (id, t1id, name) values (1, 1, 'A');

-- delete from the master table
delete from tst_t1 where id = 1;

I also tried with "on delete no action" instead of "on delete restrict", but
the result did not change.
Expected behavior:
the last delete statement works fine: all records we inserted are deleted,
and no error is thrown.
For example, in Oracle the same scenario works without error.
"""

output_text = """
insert into tst_t1 (id, name) values (1, 'T1');
insert into tst_a (id, t1id, name) values (1, 1, 'A');
delete from tst_t1 where id = 1;
"""

prompt = "Task: extract the Postgres  SQL query snippet from the raw text. For example:" + \
    "example input raw text: " + raw_text + \
    "the output of example should be the SQL snippest:" + output_text + \
    "if there is no SQL query in the raw text, the output should be empty string, like \"\" don't need any other text" + \
    "Here is the raw text: " + "{}" + \
    "the SQL query snippet is: (directly output sql without other text) "


base_url = "https://api.deepseek.com"
client = OpenAI(api_key=api_key, base_url=base_url)

n = len(pgmailing_msgs)


def remove_sql_prefix_suffix(text):
    # Remove the ```sql prefix and ``` suffix
    text = text.strip()
    if text.startswith('```sql') and text.endswith('```'):
        # Remove the prefix and suffix
        text = text[6:-3]

    return text.strip('`').strip()


cnt = 0
threshold = 200
section_info = {}

for msg_id, msg in pgmailing_msgs.items():
    msg_id = msg_id.strip()

    cnt += 1
    if msg_id in exist_msg_id_pool:
        continue

    idx = len(exist_msg_id_pool) + 1
    text = msg["text"]
    content = prompt.format(text)
    msgs = [
        {
            "role": "system",
            "content": "You are a helpful data cleaner"
        },
        {
            "role": "user",
            "content": content
        }
    ]
    try:
        response = client.chat.completions.create(
            model="deepseek-chat",
            messages=msgs,
            temperature=1.0,
        )
    except Exception as e:
        print(f"==> Error: {e}")
        exist_msg_id_pool[msg_id] = idx
        continue

    res = response.choices[0].message.content
    res = res.strip()
    exist_msg_id_pool[msg_id] = idx
    sql_text = remove_sql_prefix_suffix(res)

    if res == "" or sql_text == "" or sql_text == "\"\"":
        print(f"==> No SQL query found in the {idx}-th message")
    else:

        section_info[msg_id] = {
            "subject": msg["subject"],
            "sql": sql_text
        }
        print(f"==> Processed {idx}/{n} messages")

    # Save the processed messages
    if idx % threshold == 0 or cnt == n:
        print(
            f"[CheckPoint] ==> Save the processed {idx - threshold} - {idx} messages")
        raw_sqls_file_path = os.path.join(
            raw_sqls_dir_path, f"{idx-threshold}-{idx}.json")
        with open(raw_sqls_file_path, "w", encoding="utf-8") as f:
            json.dump(section_info, f)

        print(f"[CheckPoint] ==> Update footprint in record.txt")
        with open(raw_sqls_record_path, "w", encoding="utf-8") as f:
            json.dump(exist_msg_id_pool, f)
        
        section_info = {}
