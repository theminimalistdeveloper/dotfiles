#!/bin/sh
case "$(uname)" in
    Darwin)
        memory_pressure 2>/dev/null | awk '/percentage/ {printf "%.0f", 100 - $5}'
        ;;
    Linux)
        free | awk '/Mem:/ {printf "%.0f", $3/$2 * 100}'
        ;;
esac
