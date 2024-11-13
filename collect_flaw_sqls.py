"""
Collect all flawed SQL queries
"""


import os
import json
from collections import defaultdict

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

flaw_sqls_error_hint = {}
for file_paths in flaw_sql_file_paths:
    with open(file_paths, 'r') as f:
        tmp = json.load(f)
        flaw_sqls_error_hint.update(tmp)

print(f"==> Load all flaw SQL queries {len(flaw_sqls_error_hint)}")


out = defaultdict(dict)                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                 
for msg_id, error_hint in flaw_sqls_error_hint.items():
    if msg_id not in raw_sqls:
        continue

    out[msg_id] = {
        "sql": raw_sqls[msg_id]["sql"],
        "error_hint": error_hint
    }

file_path = "./tmp/raw/flaw_sqls.json"
with open(file_path, 'w') as f:
    json.dump(out, f)

print(f"==> We have {len(out)} flawed SQL queries")
print(f"==> Save the flawed SQL queries to {file_path}")
