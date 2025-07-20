#!/bin/bash

source /home/$USER/.custom/general.sh

logo="$wireguard_icon"
INTERFACE="$USER"
if sudo wg show "$INTERFACE" &> /dev/null; then
  source ~/.cache/wal/colors.sh &&  notify-send "Wireguard" "Tunnel $INTERFACE is running, stopping..." -i $logo
  sudo wg-quick down "$INTERFACE"
else
  source ~/.cache/wal/colors.sh &&  notify-send "Wireguard" "Tunnel $INTERFACE is not running, starting..." -i $logo
  sudo wg-quick up "$INTERFACE"
fi

