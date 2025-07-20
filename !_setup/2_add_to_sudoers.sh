#!/bin/bash

USER_NAME="${1:-$USER}"
SUDOERS_FILE="/etc/sudoers.d/custom-user"

if sudo grep -qE "^$USER_NAME\b" /etc/sudoers /etc/sudoers.d/* 2>/dev/null; then
    echo "User '$USER_NAME' already has sudo access."
    exit 0
fi

echo "$USER_NAME ALL=(ALL:ALL) ALL" | sudo tee "$SUDOERS_FILE" > /dev/null

if sudo visudo -c -f "$SUDOERS_FILE" &>/dev/null; then
    echo "User '$USER_NAME' successfully added to sudoers."
else
    echo "Error: invalid sudoers syntax, deleting file..."
    sudo rm -f "$SUDOERS_FILE"
    exit 1
fi
