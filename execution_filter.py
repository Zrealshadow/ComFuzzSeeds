# -*- coding: utf-8 -*-
# @author: lingze
# @time: 2024/11/13

# %%

import json
import configparser
import sqlalchemy
from sqlalchemy import create_engine, URL
from sqlalchemy.exc import SQLAlchemyError

# %%
# connect to postgresql database
config = configparser.ConfigParser()
config.read('./db.ini')
db_config = dict(config.items('database'))

url_obj = URL.create(
    "postgresql+psycopg2",
    username=db_config['user'],
    password=db_config['password'],
    host=db_config['host'],
    port=db_config['port'],
    database=db_config['database'],
)
print(url_obj)
# statement timeout 10_000 ms
args={"options": "-c statement_timeout=10000"}
engine = create_engine(url_obj, connect_args=args)


# %%
# read the sqls files
path = './tmp/clean_sqls/correct_sqls.json'
with open(path, 'r', encoding='utf-8') as f:
    sqls = json.load(f)
    print(f"The number of correct sqls is {len(sqls)}")

path = './tmp/clean_sqls/fixed_flaw_sqls.json'
with open(path, 'r', encoding='utf-8') as f:
    tmp_sqls = json.load(f)
    print(f"The number of fixed flaw sqls is {len(tmp_sqls)}")
    sqls.update(tmp_sqls)
    

# %%

seed_sql_snippets = []
cnt = 0
n = len(sqls)
with engine.connect() as conn:
    for _, sql_snippet in sqls.items():
        try:
            with conn.begin() as trans:
                    conn.execute(sqlalchemy.text(sql_snippet))
                # Rollback the transaction to prevent changes
            trans.rollback()
            seed_sql_snippets.append(sql_snippet)
            print(f"Progress {cnt} / {n} - effective seed {len(seed_sql_snippets)} - SQL snippet can be executed independently")
        except SQLAlchemyError as e:
            print(f"Progress {cnt} / {n} - effective seed {len(seed_sql_snippets)} -SQL snippet can not be executed independently")
        
        cnt += 1
# %%

# save seed_sql_snippets as text file
path = './seeds'

for idx, sql_snippet in enumerate(seed_sql_snippets):
    file_name = f'{path}/{idx}.sql'
    with open(file_name, 'w', encoding='utf-8') as f:
        f.write(sql_snippet)
        f.write('\n')
        
print(f"Save {len(seed_sql_snippets)} seed sql snippets to {path}")
# %%
