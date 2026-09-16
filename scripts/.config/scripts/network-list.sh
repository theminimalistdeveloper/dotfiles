#!/usr/bin/env sh
# lists available wifi networks as lines: ssid<TAB>type<TAB>connected(0/1)<TAB>known(0/1)
# connected networks are listed first, best effort, no output on error

wlan=$(iw dev 2>/dev/null | awk '/^[[:space:]]+Interface/{print $2; exit}')
[ -z "$wlan" ] && exit 0

iindex=$(cat "/sys/class/net/$wlan/ifindex" 2>/dev/null) || exit 0
station="/net/connman/iwd/0/$iindex"

busctl --system --quiet call net.connman.iwd "$station" net.connman.iwd.Station Scan 2>/dev/null

for i in 1 2 3 4 5 6 7 8; do
  scanning=$(busctl --system --quiet get-property net.connman.iwd "$station" net.connman.iwd.Station Scanning 2>/dev/null | tr -d '\"\n ')
  [ "$scanning" = "false" ] && break
  sleep 0.25
done

list=
for i in 1 2 3 4 5 6 7 8; do
  list=$(busctl --system call net.connman.iwd "$station" net.connman.iwd.Station GetOrderedNetworks 2>/dev/null \
    | awk '{ for (i = 1; i <= NF; i++) { n++; if (n > 2 && (n - 3) % 2 == 0) { gsub(/"/, "", $i); print $i } } }')
  [ -n "$list" ] && break
  sleep 0.5
done
[ -z "$list" ] && exit 0

out=
while read -r path; do
  [ -z "$path" ] && continue
  path=$(printf '%s' "$path" | tr -d '"')
  name=$(busctl --system --quiet get-property net.connman.iwd "$path" net.connman.iwd.Network Name 2>/dev/null \
    | sed -E 's/^[a-z]+ //; s/^"//; s/"$//')
  type=$(busctl --system --quiet get-property net.connman.iwd "$path" net.connman.iwd.Network Type 2>/dev/null \
    | sed -E 's/^[a-z]+ //; s/^"//; s/"$//')
  conn=$(busctl --system --quiet get-property net.connman.iwd "$path" net.connman.iwd.Network Connected 2>/dev/null \
    | sed -E 's/^[a-z]+ //; s/^"//; s/"$//')
  knownpath=$(busctl --system --quiet get-property net.connman.iwd "$path" net.connman.iwd.Network KnownNetwork 2>/dev/null \
    | sed -E 's/^[a-z]+ //; s/^"//; s/"$//')
  [ -z "$name" ] && continue
  [ "$conn" != "true" ] && conn="false"
  if [ -n "$knownpath" ] && [ "$knownpath" != "/" ]; then known=1; else known=0; fi
  out="$out
$name	$type	$conn	$known"
done <<EOF
$list
EOF

printf '%s\n' "$out" | awk -F '\t' '
  NF {
    if ($3 == "true") connected = connected $0 "\n"
    else others = others $0 "\n"
  }
  END { printf "%s%s", connected, others }
'
