#!/bin/bash

check_log_file() {
    if [[ ! -f "$1" || ! -r "$1" ]]; then
        echo "Error: Log file does not exist or is not readable."
        exit 1
    fi
}

total_requests() {
    wc -l < "$1"
}

successful_requests_percentage() {
    total=$(total_requests "$1")
    successful=$(grep -c 'HTTP/1.[01]" 2[0-9][0-9] ' "$1")
    
    if [[ $total -eq 0 ]]; then
        echo 0
    else
        echo $((successful * 100 / total))
    fi
}

most_active_user() {
    awk '{print $1}' "$1" | sort | uniq -c | sort -nr | head -1 | awk '{print $2}'
}

if [[ $# -ne 1 ]]; then
    echo "Usage: $0 path_to_log_file"
    exit 1
fi

log_file="$1"

check_log_file "$log_file"

total_requests_count=$(total_requests "$log_file")
successful_requests_pct=$(successful_requests_percentage "$log_file")
active_user=$(most_active_user "$log_file")

echo "Total Requests Count: $total_requests_count"
echo "Percentage of Successful Requests: $successful_requests_pct%"
echo "Most Active User: $active_user"
