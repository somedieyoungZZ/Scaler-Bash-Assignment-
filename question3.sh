#!/bin/bash

check_service_name() {
    if [[ -z "$1" ]]; then
        echo "Usage: $0 service_name"
        exit 1
    fi
}

check_service_status() {
    service_name="$1"

    if systemctl is-active --quiet "$service_name"; then
        echo "The service '$service_name' is running."
    else
        echo "The service '$service_name' is not running."
    fi
}

check_service_name "$1"
service_name="$1"
check_service_status "$service_name"
