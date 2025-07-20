#!/bin/bash

source /home/$USER/.custom/general.sh

choice=$(cliphist list | wofi --dmenu -s $wofi_dir/style-clipboard.css --prompt "Search in Clipboard:" -n)

if [[ "$choice" == "clear" ]]; then
    cliphist wipe
else
    echo "$choice" | cliphist decode | wl-copy
fi
