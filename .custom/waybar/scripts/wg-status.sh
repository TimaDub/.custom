#!/bin/bash

if sudo wg show $USER | grep -q interface; then
    echo '{"text": "", "tooltip": "WireGuard active", "class": "vpn-on"}'
else
    echo '{"text": "", "tooltip": "WireGuard inactive", "class": "vpn-off"}'
fi
