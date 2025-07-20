#!/bin/bash

# Colors for output
GREEN='\033[0;32m'
YELLOW='\033[0;33m'
RED='\033[0;31m'
NC='\033[0m' # No Color

cp -r "./custom" "/usr/share/.custom/"

# Source directory
SOURCE_DIR="/usr/share/.custom"

# Target directory
TARGET_DIR="$HOME/.test"

# Create target directory if it doesn't exist
mkdir -p "$TARGET_DIR"

# Function to create symlinks
create_symlink() {
    local src="$1"
    local dest="$2"
    
    # Create parent directories if they don't exist
    mkdir -p "$(dirname "$dest")"
    
    # Check if the destination already exists
    if [ -e "$dest" ]; then
        # If it's already a symlink pointing to our source, skip it
        if [ -L "$dest" ] && [ "$(readlink "$dest")" = "$src" ]; then
            echo -e "${YELLOW}Symlink already exists and points to the right location: $dest${NC}"
            return
        fi
        
        # Backup the existing file/directory
        local backup="${dest}.bak.$(date +%Y%m%d%H%M%S)"
        echo -e "${YELLOW}Backing up existing file/directory to: $backup${NC}"
        mv "$dest" "$backup"
    fi
    
    # Create the symlink
    ln -s "$src" "$dest"
    echo -e "${GREEN}Created symlink: $dest -> $src${NC}"
}

echo "Creating symlinks from $SOURCE_DIR to $TARGET_DIR"

# Hyprland
create_symlink "$SOURCE_DIR/hypr/hyprland.conf" "$TARGET_DIR/hypr/hyprland.conf"
create_symlink "$SOURCE_DIR/hypr/hyprlock.conf" "$TARGET_DIR/hypr/hyprlock.conf"

# Waybar
create_symlink "$SOURCE_DIR/waybar/config" "$TARGET_DIR/waybar/config"
create_symlink "$SOURCE_DIR/waybar/style.css" "$TARGET_DIR/waybar/style.css"

# Starship
create_symlink "$SOURCE_DIR/starship/starship.toml" "$TARGET_DIR/starship.toml"

# Rofi (excluding scripts directory)
mkdir -p "$TARGET_DIR/rofi"
for file in "$SOURCE_DIR"/rofi/*; do
    base_name=$(basename "$file")
    if [ "$base_name" != "scripts" ]; then
        create_symlink "$file" "$TARGET_DIR/rofi/$base_name"
    fi
done

# Paru
create_symlink "$SOURCE_DIR/paru/paru.conf" "$TARGET_DIR/paru/paru.conf"

# Swaync (all files except scripts)
mkdir -p "$TARGET_DIR/swaync"
for item in "$SOURCE_DIR"/swaync/*; do
    base_name=$(basename "$item")
    if [ "$base_name" != "scripts" ]; then
        create_symlink "$item" "$TARGET_DIR/swaync/$base_name"
    fi
done

# Kitty (all files)
mkdir -p "$TARGET_DIR/kitty"
for item in "$SOURCE_DIR"/kitty/*; do
    base_name=$(basename "$item")
    create_symlink "$item" "$TARGET_DIR/kitty/$base_name"
done

# GTK settings
create_symlink "$SOURCE_DIR/gtk/gtk-3.0/settings.ini" "$TARGET_DIR/gtk-3.0/settings.ini"
create_symlink "$SOURCE_DIR/gtk/gtk-4.0/settings.ini" "$TARGET_DIR/gtk-4.0/settings.ini"

# QT settings
create_symlink "$SOURCE_DIR/qt6ct/qt6ct.conf" "$TARGET_DIR/qt6ct/qt6ct.conf"
create_symlink "$SOURCE_DIR/qt5ct/qt5ct.conf" "$TARGET_DIR/qt5ct/qt5ct.conf"

# Fish
create_symlink "$SOURCE_DIR/fish/config.fish" "$TARGET_DIR/fish/config.fish"
create_symlink "$SOURCE_DIR/fish/auto-Hypr.fish" "$TARGET_DIR/fish/auto-Hypr.fish"

# Fastfetch
mkdir -p "$TARGET_DIR/fastfetch"
for item in "$SOURCE_DIR"/fastfetch/*; do
    base_name=$(basename "$item")
    create_symlink "$item" "$TARGET_DIR/fastfetch/$base_name"
done

# Wal
mkdir -p "$TARGET_DIR/wal"
for item in "$SOURCE_DIR"/wal/*; do
    base_name=$(basename "$item")
    create_symlink "$item" "$TARGET_DIR/wal/$base_name"
done

# Wlogout
mkdir -p "$TARGET_DIR/wlogout"
for item in "$SOURCE_DIR"/wlogout/*; do
    base_name=$(basename "$item")
    create_symlink "$item" "$TARGET_DIR/wlogout/$base_name"
done

echo -e "\n${GREEN}All symlinks have been created successfully!${NC}"

# XDG Desktop Portal
create_symlink "$SOURCE_DIR/environment.d/99xdg-desktop-portal.conf" "$TARGET_DIR/environment.d/99xdg-desktop-portal.conf"

# Profile
create_symlink "$SOURCE_DIR/.profile" "$TARGET_DIR/.profile"