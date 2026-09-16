#!/usr/bin/env sh
# outputs: mode signal ssid wlan
# mode: wifi | ethernet | off

wlan=$(iw dev 2>/dev/null | awk '/^[[:space:]]+Interface/{print $2; exit}')

if [ -n "$wlan" ]; then
  link=$(iw dev "$wlan" link 2>/dev/null)
  ssid=$(printf '%s\n' "$link" | awk -F': ' '/SSID:/{print $2; exit}')
  if [ -n "$ssid" ]; then
    dbs=$(printf '%s\n' "$link" | awk '/^[[:space:]]+signal:/{gsub(/dBm/, "", $2); printf "%d", $2; exit}')
    dbs=${dbs:-0}
    pct=$(( (90 + dbs) * 100 / 60 ))
    [ "$pct" -lt 0 ] && pct=0
    [ "$pct" -gt 100 ] && pct=100
    printf 'wifi %s %s %s\n' "$pct" "$ssid" "$wlan"
    exit 0
  fi
fi

for d in /sys/class/net/*; do
  b=$(basename "$d")
  case "$b" in
    lo|wlan*|virbr*|docker*|veth*) continue ;;
  esac
  [ "$(cat "$d/operstate" 2>/dev/null)" = "up" ] && {
    printf 'ethernet 100 %s\n' "$b"
    exit 0
  }
done

printf 'off 0 --\n'
