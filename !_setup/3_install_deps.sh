#!/bin/bash

sudo pacman -Syy

sudo pacman -Syyu --noconfirm && sudo pacman -S --needed --noconfirm gnome-calculator gnome-disk-utility gnome-font-viewer gnome-keyring gnome-network-displays gnome-settings-daemon gnome-tweaks swww swaybg starship swayidle waybar xdg-desktop-portal xdg-user-dirs xdg-utils xorg-xhost xorg-xrandr xorg-xwayland xsettingsd v4l2loopback-dkms ttf-dejavu ttf-firacode-nerd ttf-font-awesome ttf-hack ttf-jetbrains-mono ttf-jetbrains-mono-nerd ttf-liberation ttf-opensans ttf-ubuntu-font-family tela-circle-icon-theme-all terminus-font slurp grim qt5-base qt5ct qt5-quickcontrols qt5-wayland qt6-5compat qt6-base qt6ct qt6-multimedia-ffmpeg qt6-virtualkeyboard qt6-wayland python-uv python python-pip polkit-gnome playerctl pavucontrol pcsclite pipewire pipewire-alsa pipewire-audio pipewire-jack pipewire-pulse os-prober grub grub-customizer nwg-look ntfs-3g nvidia-dkms nvidia-settings nvidia-utils noto-fonts noto-fonts-cjk noto-fonts-emoji noto-fonts-extra nodejs networkmanager network-manager-applet nfs-utils nilfs-utils nautilus mesa mesa-utils linux-atm linux-firmware-marvell linux-zen linux-zen-headers kitty jq less libnotify lollypop make git hyprshot hypridle hyperv gtk2 gtk3 gtk4 gucharmap gvfs gvfs-gphoto2 freerdp flatpak fish firefox-developer-edition file-roller fastfetch eza fakeroot docker efibootmgr discord curl btop cpio blueman bluez bluez-utils bash base base-devel adwaita-cursors adwaita-fonts adw-gtk-theme alsa-utils amd-ucode 7zip bridge-utils bottom lsd syslinux wireguard-tools wofi wireless_tools wireplumber rofi-wayland reflector pulsemixer nano mpv mkinitcpio mkinitcpio-archiso mkinitcpio-nfs-utils gsettings-desktop-schemas greetd glib2 sudo vim zip unzip go rust extra-cmake-modules cmake


cd /tmp 
git clone https://aur.archlinux.org/paru.git
cd paru
makepkg -si
cd ..
rm -rf paru

paru -S --needed \
    aquamarine-git \
    caffeine \
    catppuccin-gtk-theme-macchiato \
    catppuccin-gtk-theme-mocha \
    catppuccin-qt5ct-git \
    clock-rs-git \
    cursor-bin \
    docker-desktop \
    downgrade \
    dracula-icons-theme \
    grub-customizer \
    hyprcursor-git \
    hyprgraphics-git \
    hyprland-git \
    hyprland-protocols-git \
    hyprland-qt-support-git \
    hyprland-qtutils-git \
    hyprlang-git \
    hyprlock-git \
    hyprpaper-git \
    hyprutils-git \
    hyprwayland-scanner-git \
    illogical-impulse-bibata-modern-classic-bin \
    pyprland \
    python-colormath \
    python-pywalfox \
    python-pywal16 \
    qt5-styleplugins \
    snixembed \
    swaync-git \
    tokyonight-gtk-theme-git \
    unityhub \
    visual-studio-code-bin \
    wireguard-dkms \
    wlogout \
    xwaylandvideobridge \
    xdg-desktop-portal-hyprland-git \
    yay \
    libuvc \
    darkly

systemctl enable --now docker.service
systemctl enable --now NetworkManager.service
systemctl enable --now bluetooth.service
systemctl enable greetd.service
