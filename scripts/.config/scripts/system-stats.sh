#!/usr/bin/env sh

# outputs: cpu ram disk sysTemp gpuTemp
# never fails hard: every token is emitted even if a sensor is missing

# CPU usage over two /proc/stat samples
read -r _ a1 b1 c1 d1 e1 f1 g1 h1 i1 j1 k1 _ < /proc/stat
sleep 0.2
read -r _ a2 b2 c2 d2 e2 f2 g2 h2 i2 j2 k2 _ < /proc/stat

idle1=$((d1 + e1))
busy1=$((a1 + b1 + c1 + f1 + g1 + h1 + i1 + j1))
idle2=$((d2 + e2))
busy2=$((a2 + b2 + c2 + f2 + g2 + h2 + i2 + j2))

DELTA=$((busy2 + idle2 - busy1 - idle1))
[ "$DELTA" -le 0 ] && DELTA=1
cpu=$(( (busy2 - busy1) * 100 / DELTA ))
[ "$cpu" -gt 100 ] && cpu=100
[ "$cpu" -lt 0 ] && cpu=0

# RAM usage
total_kb=$(awk '/^MemTotal:/ {print $2}' /proc/meminfo)
avail_kb=$(awk '/^MemAvailable:/ {print $2}' /proc/meminfo)
[ "$total_kb" -gt 0 ] || total_kb=1
ram=$(( (total_kb - avail_kb) * 100 / total_kb ))

# Disk usage on root
disk=$(df -Pk / | awk 'NR==2 {print $5}' | tr -d '%')

# hwmon lookup by chip name
find_chip() {
  for d in /sys/class/hwmon/hwmon*; do
    [ -n "$d" ] && [ "$(cat "$d/name" 2>/dev/null)" = "$1" ] && { echo "$d"; return 0; }
  done
  return 1
}

sys_temp=0
for c in k10temp coretemp; do
  chip=$(find_chip "$c" 2>/dev/null) || continue
  if [ -r "$chip/temp1_input" ]; then
    sys_temp=$(( $(cat "$chip/temp1_input") / 1000 ))
    break
  fi
done
if [ "$sys_temp" -eq 0 ]; then
  for f in /sys/class/hwmon/hwmon*/temp*_input; do
    if [ -r "$f" ]; then sys_temp=$(( $(cat "$f") / 1000 )); break; fi
  done
fi

# GPU temp: nvidia -> amdgpu -> i915 -> "--"
gpu_temp="--"
if command -v nvidia-smi >/dev/null 2>&1; then
  gpu_temp=$(nvidia-smi --query-gpu=temperature.gpu --format=csv,noheader,nounits 2>/dev/null)
fi
[ -z "$gpu_temp" ] && gpu_temp="--"
if [ "$gpu_temp" = "--" ]; then
  for g in amdgpu i915; do
    chip=$(find_chip "$g" 2>/dev/null) || continue
    if [ -r "$chip/temp1_input" ]; then
      gpu_temp=$(( $(cat "$chip/temp1_input") / 1000 ))
      break
    fi
  done
fi

printf '%s %s %s %s %s\n' "${cpu:-0}" "${ram:-0}" "${disk:-0}" "${sys_temp:-0}" "${gpu_temp:---}"
