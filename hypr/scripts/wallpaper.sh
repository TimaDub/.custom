#!/bin/bash

source /home/$USER/.custom/general.sh

number=$1
CURRENT_WALLPAPER_DIR="$WALLPAPER_DIR/$number"

menu() {
    find "${CURRENT_WALLPAPER_DIR}" -type f \( -iname "*.jpg" -o -iname "*.jpeg" -o -iname "*.png" -o -iname "*.gif" \) | awk '{print "img:"$0}'
}
main() {
    choice=$(menu | wofi -c $wofi_dir/wallpaper -s $wofi_dir/style-wallpaper.css --show dmenu --prompt "Select Wallpaper:" -n)
    selected_wallpaper=$(echo "$choice" | sed 's/^img://')
    swww img "$selected_wallpaper" --transition-type any --transition-fps 60 --transition-duration .5
    wal -i "$selected_wallpaper" -n --cols16
    swaync-client --reload-css
    cat ~/.cache/wal/colors-kitty.conf > $kitty_current_theme
    pywalfox update
    source ~/.cache/wal/colors.sh && cp -r $wallpaper $WALLPAPER_DIR/pywallpaper.jpg
    $hypr_scripts_dir/gtk-wal.sh
}
main
