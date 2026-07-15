#!/bin/zsh
MAC="00:1F:20:92:15:08"

# monitor bluetooth event instead of polling every second lah
bluetoothctl monitor | while read -r line; do
    if [[ "$line" == *"$MAC"* && "$line" == *"Disconnected"* ]]; then
        sleep 1
        bluetoothctl connect $MAC &> /dev/null &
    fi
done
