#!/bin/bash
airpod_id=$(bluetoothctl devices | grep 'AirPods Pro' | awk '{print $2}')
airpod_state=$(bluetoothctl info "$airpod_id" | awk '/Connected/{print$2}')

if [[ -z "$airpod_id" ]]; then
  echo "AirPods not found in paired devices"
  exit 1
fi

if [[ "$airpod_state" == "yes" ]]; then
  bluetoothctl disconnect "$airpod_id"
else
  bluetoothctl connect "$airpod_id"
fi
