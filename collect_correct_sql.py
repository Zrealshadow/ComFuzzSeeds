import os
import json


raw_sql_dir = "./tmp/raw/sqls"
raw_sql_file_paths = [os.path.join(raw_sql_dir, file)
                      for file in os.listdir(raw_sql_dir)]


raw_sqls = {}
for file_paths in raw_sql_file_paths:
    with open(file_paths, 'r') as f:
        tmp = json.load(f)
        raw_sqls.update(tmp)

print(f"==> Load all raw SQL queries {len(raw_sqls)}")


flaw_sql_dir = "./tmp/raw/flaw"
flaw_sql_file_paths = [os.path.join(flaw_sql_dir, file)
                       for file in os.listdir(flaw_sql_dir)]

flaw_sqls = {}
for file_paths in flaw_sql_file_paths:
    with open(file_paths, 'r') as f:
        tmp = json.load(f)
        flaw_sqls.update(tmp)

print(f"==> Load all flaw SQL queries {len(flaw_sqls)}")

print(f"==> we have all SQL queries {len(raw_sqls)}")


# json msg_id -> sql
correct_sqls = {}


for msg_id, val in raw_sqls.items():
    if msg_id in flaw_sqls:
        continue
    correct_sqls[msg_id] = val["sql"]

file_path = "./tmp/clean_sqls/correct_sqls.json"
with open(file_path, 'w') as f:
    json.dump(correct_sqls, f)

print(f"==> We have {len(correct_sqls)} correct SQL queries")
print(f"==> Save the correct SQL queries to {file_path}")
