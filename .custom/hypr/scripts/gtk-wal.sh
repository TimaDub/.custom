#!/bin/bash

source /home/$USER/.custom/general.sh

COLORS_FILE="$HOME/.cache/wal/colors.json"
PYTHON="$hypr_scripts_dir/.venv/bin/python3"
SNAP_COLOR_SCRIPT="$hypr_scripts_dir/color.py"

MAIN_COLOR=$(jq -r '.colors.color9' "$COLORS_FILE")

snapped_main_color=$("$PYTHON" "$SNAP_COLOR_SCRIPT" "$MAIN_COLOR")
SELECTED_GTK_THEME="catppuccin-macchiato-blue-standard+default" 
SELECTED_ICON_THEME="Tela-circle-dracula"

case "$snapped_main_color" in
    "#FF0000")
        SELECTED_GTK_THEME="catppuccin-macchiato-red-standard+default"
        SELECTED_ICON_THEME="Tela-circle-red"
        ;;
    "#684A37")
        SELECTED_GTK_THEME="catppuccin-macchiato-peach-standard+default"
        SELECTED_ICON_THEME="Tela-circle-brown"
        ;;
    "#00FF00")
        SELECTED_GTK_THEME="catppuccin-macchiato-green-standard+default"
        SELECTED_ICON_THEME="Tela-circle-green"
        ;;
    "#0000FF")
        SELECTED_GTK_THEME="catppuccin-macchiato-blue-standard+default"
        SELECTED_ICON_THEME="Tela-circle-blue"
        ;;
    "#FFFF00")
        SELECTED_GTK_THEME="catppuccin-macchiato-yellow-standard+default"
        SELECTED_ICON_THEME="Tela-circle-yellow"
        ;;
    "#00FFFF")
        SELECTED_GTK_THEME="catppuccin-macchiato-teal-standard+default"
        SELECTED_ICON_THEME="Tela-circle"
        ;;
    "#FF00FF")
        SELECTED_GTK_THEME="catppuccin-macchiato-pink-standard+default"
        SELECTED_ICON_THEME="Tela-circle-pink"
        ;;
    "#FFA500")
        SELECTED_GTK_THEME="catppuccin-macchiato-peach-standard+default"
        SELECTED_ICON_THEME="Tela-circle-ubuntu"
        ;;
    "#800080")
        SELECTED_GTK_THEME="catppuccin-macchiato-mauve-standard+default"
        SELECTED_ICON_THEME="Tela-circle-purple"
        ;;
    "#FFFFFF")
        SELECTED_GTK_THEME="catppuccin-macchiato-rosewater-standard+default"
        SELECTED_ICON_THEME="Tela-circle-grey"
        ;;
    "#000000")
        SELECTED_GTK_THEME="catppuccin-macchiato-lavender-standard+default"
        SELECTED_ICON_THEME="Tela-circle-black"
        ;;
    "#808080")
        SELECTED_GTK_THEME="catppuccin-macchiato-lavender-standard+default"
        SELECTED_ICON_THEME="Tela-circle-dracula"
        ;;
    *)
        echo "Warning: The rounded color '$snapped_main_color' does not have a direct theme mapping. Using default theme: $SELECTED_GTK_THEME"
        ;;
esac

gsettings set org.gnome.desktop.interface gtk-theme "$SELECTED_GTK_THEME"
gsettings set org.gnome.desktop.interface icon-theme "$SELECTED_ICON_THEME"
gsettings set org.gnome.desktop.interface font-name "Adwaita Sans 11"
gsettings set org.gnome.desktop.interface color-scheme 'prefer-dark'


# GTK3
GTK3_SETTINGS_FILE="$gtk3_dir/settings.ini"

sed -i '/gtk-theme-name=/d' "$GTK3_SETTINGS_FILE" 2>/dev/null || true
sed -i '/gtk-icon-theme-name=/d' "$GTK3_SETTINGS_FILE" 2>/dev/null || true
if ! grep -q "\[Settings\]" "$GTK3_SETTINGS_FILE"; then
    echo "[Settings]" >> "$GTK3_SETTINGS_FILE"
fi

# GTK4
rm "$HOME/.config/gtk-4.0/assets"
rm "$HOME/.config/gtk-4.0/gtk-dark.css"
rm "$HOME/.config/gtk-4.0/gtk.css"

ln -s /usr/share/themes/$SELECTED_GTK_THEME/gtk-4.0/assets "$HOME/.config/gtk-4.0/assets"
ln -s /usr/share/themes/$SELECTED_GTK_THEME/gtk-4.0/gtk-dark.css "$HOME/.config/gtk-4.0/gtk-dark.css"
ln -s /usr/share/themes/$SELECTED_GTK_THEME/gtk-4.0/gtk.css "$HOME/.config/gtk-4.0/gtk.css"

GTK4_SETTINGS_FILE="$gtk4_dir/settings.ini"
sed -i '/gtk-theme-name=/d' "$GTK4_SETTINGS_FILE" 2>/dev/null || true
sed -i '/gtk-icon-theme-name=/d' "$GTK4_SETTINGS_FILE" 2>/dev/null || true
if ! grep -q "\[Settings\]" "$GTK4_SETTINGS_FILE"; then
    echo "[Settings]" >> "$GTK4_SETTINGS_FILE"
fi
echo "gtk-theme-name=$SELECTED_GTK_THEME" >> "$GTK4_SETTINGS_FILE"
echo "gtk-icon-theme-name=$SELECTED_ICON_THEME" >> "$GTK4_SETTINGS_FILE"