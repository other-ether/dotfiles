#!/bin/zsh
MAC="00:1F:20:92:15:08"

while true
do
  sleep 1
  CONNECTED=$(bluetoothctl info $MAC | grep "Connected: yes")
  
  if [ -z "$CONNECTED" ]; then
    bluetoothctl connect $MAC &> /dev/null
  fi
done
