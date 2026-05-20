#!/usr/bin/env bash

interface="wlan0"

line=$(grep "$interface" /proc/net/dev)
if [ -z "$line" ]; then
  echo '{"text": " 󰤭 "}'
  exit
fi

rx=$(echo "$line" | awk '{print $2}')
tx=$(echo "$line" | awk '{print $10}')
sleep 1

line=$(grep "$interface" /proc/net/dev)
rx2=$(echo "$line" | awk '{print $2}')
tx2=$(echo "$line" | awk '{print $10}')

rx_speed=$(( (rx2 - rx) ))
tx_speed=$(( (tx2 - tx) ))

format_speed() {
  local speed=$1
  if [ "$speed" -ge 1048576 ]; then
    echo "$(awk "BEGIN { printf \"%.1f\", $speed / 1048576 }")MB/s"
  elif [ "$speed" -ge 1024 ]; then
    echo "$(awk "BEGIN { printf \"%.0f\", $speed / 1024 }")KB/s"
  else
    echo "${speed}B/s"
  fi
}

down=$(format_speed $rx_speed)
up=$(format_speed $tx_speed)

echo "{\"text\": \" $down  $up\"}"
