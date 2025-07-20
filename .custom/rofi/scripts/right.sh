#!/usr/bin/env bash

source /home/$USER/.custom/general.sh

theme='right'

# CMDs
uptime="`uptime -p | sed -e 's/up //g'`"
host=`hostname`

# Options
palette=''
clipboard=''
screenshot=''
refresh=''

run_rofi() {
	echo -e "$clipboard\n$palette\n$screenshot\n$refresh"
}
$hypr_scripts_dir/changeanim.sh 1 
chosen="$(run_rofi | rofi -dmenu -theme ${rofi_dir}/${theme}.rasi)"

case ${chosen} in
    $palette)
		exec $scripts_dir/colorpicker.sh
        ;;
    $clipboard)
		exec cliphist list | wofi --dmenu -s $wofi_dir/style-clipboard.css --prompt "Search in Clipboard:" -n | cliphist decode | wl-copy
        ;;
    $screenshot)
    mkdir -p $(xdg-user-dir PICTURES)/Screenshots && grim $(xdg-user-dir PICTURES)/Screenshots/Screenshot_"$(date '+%Y-%m-%d_%H.%M.%S')".png | grim - | wl-copy
        ;;
    $refresh)
    $hypr_scripts_dir/gtk-wal.sh
    swww img "$selected_wallpaper" --transition-type any --transition-fps 60 --transition-duration .5
    wal -i "$selected_wallpaper" -n --cols16
    killall waybar && waybar &
    swaync-client --reload-css
    cat ~/.cache/wal/colors-kitty.conf > $kitty_current_theme
    path=$(hyprctl clients -j | jq -r '.[] | select(.class=="org.gnome.Nautilus") | .title' | head -n1)
    killall nautilus
    if [[ -z "$path" ]]; then
    :
    elif [[ "$path" == "Home" ]]; then
        nautilus &
    else
    nautilus "$path" &
    fi
        ;;
esac
