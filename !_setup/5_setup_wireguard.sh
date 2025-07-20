#!/bin/bash

set -e

CONFIG_FILE="/etc/sysctl.d/99-disable-ipv6.conf"
NEEDED_CONFIG=$(
cat <<EOF
net.ipv6.conf.all.disable_ipv6 = 1
net.ipv6.conf.default.disable_ipv6 = 1
net.ipv6.conf.lo.disable_ipv6 = 1
EOF
)

echo "[*] Checking if changes are needed..."

# Check if configuration file exists
if [[ -f "$CONFIG_FILE" ]] && grep -q "net.ipv6.conf.all.disable_ipv6 = 1" "$CONFIG_FILE"; then
    echo "[=] IPv6 already disabled in config."
else
    echo "[*] Writing config to $CONFIG_FILE..."
    echo "$NEEDED_CONFIG" | sudo tee "$CONFIG_FILE" > /dev/null
fi

# Apply changes
echo "[*] Applying sysctl..."
sudo sysctl --system

# Check result
if [[ "$(cat /proc/sys/net/ipv6/conf/all/disable_ipv6)" == "1" ]]; then
    echo "[+] IPv6 successfully disabled!"
else
    echo "[!] Failed to disable IPv6."
fi

# Add rule to sudoers
SUDOERS_FILE="/etc/sudoers.d/wirequard-toggle"
RULE="$USER ALL=(ALL) NOPASSWD: /usr/bin/wg, /usr/bin/wg-quick"

echo "[*] Checking if rule exists in $SUDOERS_FILE..."

# If file exists and rule already exists — nothing to do
if [[ -f "$SUDOERS_FILE" ]] && grep -Fxq "$RULE" "$SUDOERS_FILE"; then
    echo "[=] Rule already exists, nothing to do."
else
    echo "[*] Adding rule to $SUDOERS_FILE..."
    echo "$RULE" | sudo tee "$SUDOERS_FILE" > /dev/null

    # Syntax check (important)
    sudo visudo -c -f "$SUDOERS_FILE"

    echo "[+] Rule added and passed syntax check!"
fi