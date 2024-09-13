
Copy code
#!/bin/bash

# Function to display usage information
print_help() {
    echo "Usage: $0 [<dir_path>] [<output_dir>]"
    echo ""
    echo "Options:"
    echo "  <dir_path>      The path to the directory containing subdirectories to process. Default: ./data"
    echo "  <output_dir>    The path to the directory where output will be stored. Default: ./tmp/titleAndText/"
    echo ""
    echo "Example:"
    echo "  $0 /path/to/dir /path/to/output"
    echo ""
    echo "This script iterates over all subdirectories in <dir_path> and executes the"
    echo "python segmentation.py command for each subdirectory."
    exit 0
}

# Check if the --help option is provided
if [ "$#" -eq 1 ] && [ "$1" == "--help" ]; then
    print_help
fi

# Set default values
default_dir_path="./data"
default_output_dir="./tmp/titleAndText/"

# Use default values if arguments are not provided
dir_path="${1:-$default_dir_path}"
output_dir="${2:-$default_output_dir}"


# Check if the input directory exists and is a directory
if [ ! -d "$dir_path" ]; then
    echo "Error: $dir_path is not a valid directory."
    exit 1
fi

# Create the output directory if it doesn't exist
mkdir -p "$output_dir"

# Iterate over all subdirectories in the directory
for sub_dir_path in "$dir_path"/*; do
    if [ -d "$sub_dir_path" ]; then  # Check if it's a directory
        echo "Processing directory: $sub_dir_path"
        python segmentation.py -d "$sub_dir_path" -o "$output_dir"
    else
        echo "Skipping non-directory: $sub_dir_path"
    fi
done


echo "Segmentation complete. Output stored in: $output_dir"