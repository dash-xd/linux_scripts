#!/bin/bash

# Source the function library
source ../modules/netutil.sh

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
        killp)
            killp "$@"
            ;;
        checkapp)
            checkapp "$@"
            ;;
        *)
            echo "Usage: $0 {findport|checkport|killp|checkapp} [arguments]"
            return 1
            ;;
    esac
}

# Main entry point
main() {
    local action=$1
    shift
    dispatch "$action" "$@"
}

# If the script is being executed directly, call the main function
if [[ "${BASH_SOURCE[0]}" == "${0}" ]]; then
    main "$@"
fi
