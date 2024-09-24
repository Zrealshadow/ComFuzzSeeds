#!/bin/bash
make clean

make

# Define the base directory
base_dir="./tmp/raw"

# Create necessary directories if they don't exist
if [ ! -d "${base_dir}/flaw" ]; then
    mkdir -p "${base_dir}/flaw"
fi

if [ ! -d "${base_dir}/report" ]; then
    mkdir -p "${base_dir}/report"
fi

# List SQL files in the base_dir/sqls directory
sql_files=("${base_dir}/sqls/"*.json)

# Iterate over each JSON file and execute the syntax_valid command
for sql_file in "${sql_files[@]}"; do
    if [ -f "$sql_file" ]; then  # Check if the file exists
        # Extract the base name for output filenames
        base_name=$(basename "$sql_file" .json)

        # Define output filenames
        flaw_file="${base_dir}/flaw/${base_name}.json"
        report_file="${base_dir}/report/${base_name}.txt"

        # Execute the syntax_valid command
        ./bin/syntax_valid "$sql_file" "$flaw_file" "$report_file"
        
        echo "=============================================================="
        echo "Executed: ./bin/syntax_valid $sql_file $flaw_file $report_file"
    
    fi
done
