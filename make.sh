#!/usr/bin/env bash
set -euo pipefail

function __main__ {
    case "${1:-null}" in
        'install')
            raco pkg install --force
            exit 0
        ;;

        *)
            echo "Unknown"
            exit 1
        ;;
    esac
}

__main__ "$@"
