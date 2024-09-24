
import os
import json

fixed_flaw_sql_file_path = "./tmp/raw/fixed_flaw_sqls.json"

with open(fixed_flaw_sql_file_path, 'r', encoding='utf-8') as f:
    fixed_flaw_sqls = json.load(f)


syntax_error_file_path = './tmp/raw/fixed/flaws.json'
with open(syntax_error_file_path, 'r', encoding='utf-8') as f:
    syntax_error_sqls = json.load(f)


syntax_error_msg_id = set(syntax_error_sqls.keys())


ans = {}
for msg_id, sql in fixed_flaw_sqls.items():
    if msg_id in syntax_error_msg_id:
        continue
    ans[msg_id] = sql


output_file = "./tmp/clean_sqls/fixed_flaw_sqls.json"
with open(output_file, 'w', encoding='utf-8') as f:
    json.dump(ans, f, indent=4)

print(f"==> Save the fixed flawed SQL queries to {output_file}")