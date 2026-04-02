#!/bin/sh
case "$(uname)" in
    Darwin)
        top -l 1 -n 0 2>/dev/null | awk '/CPU usage/ {printf "%.0f", $3 + $5}'
        ;;
    Linux)
        nproc=$(nproc 2>/dev/null || echo 1)
        awk -v n="$nproc" '{printf "%.0f", $1 * 100 / n}' /proc/loadavg
        ;;
esac
