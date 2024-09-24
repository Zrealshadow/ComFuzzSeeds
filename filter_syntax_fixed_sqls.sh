#!/bin/bash

sql_file="./tmp/raw/fixed_flaw_sqls.json"
flaw_file="./tmp/raw/fixed/flaws.json"
report_file="./tmp/raw/fixed/report.txt"

./bin/syntax_valid "$sql_file" "$flaw_file" "$report_file"