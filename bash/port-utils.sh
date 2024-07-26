#!/bin/bash

# Function to find an available port
findport() {
    ss -tln | awk 'NR > 1 {print $4}' | awk -F '[:]' '{print $NF}' | sort -n | uniq | awk 'NR==FNR{a[$1]; next} !($1 in a)' - <(seq 49152 65535) | head -n 1
}

# Function to check which application is running on a specific port
checkport() {
    local port=$1
    if [ -z "$port" ]; then
        echo "Usage: $0 checkport <port>"
        return 1
    fi
    sudo netstat -tuln | grep ":$port"
}

# Function to check which port an application is running on
checkapp() {
    local app_name=$1
    if [ -z "$app_name" ]; then
        echo "Usage: $0 checkapp <application_name>"
        return 1
    fi
    sudo ps aux | grep "$app_name" | grep -v "grep"
}

# Dispatch function to route arguments to the appropriate function
dispatch() {
    local action=$1
    shift
    case "$action" in
        findport)
            findport "$@"
            ;;
        checkport)
            checkport "$@"
            ;;
        checkapp)
            checkapp "$@"
            ;;
        *)
            echo "Usage: $0 {findport|checkport|checkapp} [arguments]"
            return 1
            ;;
    esac
}

# Main entry point to mimic module behavior
main() {
    local action=$1
    shift
    dispatch "$action" "$@"
}

# Export functions to mimic module exports
export -f findport
export -f checkport
export -f checkapp
export -f dispatch
export -f main

# If the script is being executed directly, call the main function
if [[ "${BASH_SOURCE[0]}" == "${0}" ]]; then
    main "$@"
fi
