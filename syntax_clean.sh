#!/bin/bash

# Define the base directory
base_dir="./tmp/raw"

# Define the directories to clean
flaw_dir="${base_dir}/flaw"
report_dir="${base_dir}/report"
sqls_dir="${base_dir}/sqls"

# Remove files in the flaw directory
if [ -d "$flaw_dir" ]; then
    echo "Cleaning up files in $flaw_dir..."
    rm -f "${flaw_dir}"/*
fi

# Remove files in the report directory
if [ -d "$report_dir" ]; then
    echo "Cleaning up files in $report_dir..."
    rm -f "${report_dir}"/*
fi


echo "Cleanup completed."