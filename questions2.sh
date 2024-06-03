#!/bin/bash

# Function to check if the directory exists and is readable
check_directory() {
    if [[ ! -d "$1" || ! -r "$1" ]]; then
        echo "Error: Directory does not exist or is not readable."
        exit 1
    fi
}

# Function to count and list file types
count_file_types() {
    find "$1" -type f | awk -F. '{
        if (NF>1) {
            ext=$(NF>1 ? $NF : "no_extension")
            count[ext]++
        } else {
            count["no_extension"]++
        }
    }
    END {
        for (ext in count) {
            printf "%s: %d\n", ext, count[ext]
        }
    }' | sort
}

# Main script
if [[ $# -ne 1 ]]; then
    echo "Usage: $0 path_to_directory"
    exit 1
fi

directory="$1"

check_directory "$directory"

count_file_types "$directory"
