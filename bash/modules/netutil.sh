#!/bin/bash

# Define the functions

findport() {
    local min_port=${1:-49152}
    local max_port=${2:-65535}

    if [[ -n "$1" && -z "$2" ]]; then
        echo "Usage: findport <min_port> <max_port>"
        return 1
    fi

    ss -tln | awk 'NR > 1 {print $4}' | awk -F '[:]' '{print $NF}' | sort -n | uniq | awk -v min="$min_port" -v max="$max_port" 'NR==FNR{a[$1]; next} $1 >= min && $1 <= max && !($1 in a)' - <(seq "$min_port" "$max_port") | head -n 1
}

# checkport() {
#     local port=$1
#     if [ -z "$port" ]; then
#         echo "Usage: checkport <port>"
#         return 1
#     fi
#     sudo netstat -tulpn | grep ":$port"
# }

checkport() {
    local port=$1
    if [ -z "$port" ]; then
        echo "Usage: checkport <port>"
        return 1
    fi
    fuser -v -n tcp $port
}

checkapp() {
    local app_name=$1
    if [ -z "$app_name" ]; then
        echo "Usage: checkapp <application_name>"
        return 1
    fi
    ps aux | grep "$app_name" | grep -v "grep"
}

killp() {
    local pid=$1
    if [ -z "$pid" ]; then
        echo "Usage: killp <pid>"
        return 1
    fi
    echo $pid
    kill $pid

}

# Export functions if they need to be used in subshells
export -f findport
export -f checkport
export -f checkapp
