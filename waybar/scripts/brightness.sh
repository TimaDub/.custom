#!/bin/bash

BRIGHTNESS=$(ddcutil getvcp 10 2>/dev/null | sed -n 's/.*current value = *\([0-9]*\),.*/\1/p')

NEW=$((BRIGHTNESS + 10))

if [ "$NEW" -gt 100 ]; then
    NEW=0
fi

ddcutil setvcp 10 "$NEW" >/dev/null

echo "{\"text\": \"☀ $NEW\", \"tooltip\": \"Яркость установлена: $NEW%\"}"
