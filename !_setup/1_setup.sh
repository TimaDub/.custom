#!/bin/bash
set -e

# 1. Uncomment locales
echo ">> Uncomment locales"
sed -i 's/^#\s*\(en_US.UTF-8 UTF-8\)/\1/' /etc/locale.gen
sed -i 's/^#\s*\(ru_RU.UTF-8 UTF-8\)/\1/' /etc/locale.gen
sed -i 's/^#\s*\(uk_UA.UTF-8 UTF-8\)/\1/' /etc/locale.gen
sed -i 's/^#\s*\(de_DE.UTF-8 UTF-8\)/\1/' /etc/locale.gen

# 2. Generate locales
echo ">> Generate locales"
locale-gen

# 3. Set system locale
echo "LANG=en_US.UTF-8" > /etc/locale.conf

# 4. Create user Tima_D
USERNAME="Tima_D"
echo ">> Create user $USERNAME"
useradd -m -G wheel -s /bin/bash "$USERNAME"

# 5. Set password for user
echo ">> Set password for $USERNAME"
passwd "$USERNAME"

# 6. Enable sudo for wheel group
echo ">> Enable sudo for wheel group"
sed -i 's/^# \(%wheel ALL=(ALL:ALL) ALL\)/\1/' /etc/sudoers

# 7. Set new password for root (sudo)
echo ">> Set new password for root (sudo)"
passwd root

echo "Ready!"
