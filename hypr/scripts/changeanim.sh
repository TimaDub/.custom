#!/bin/bash

source /home/$USER/.custom/general.sh

HYPR_CONF="$hypr_hyprland_dir/rules.conf"
NEW_ANIM_LINE=""

case "$1" in
    "0") # bottom
        NEW_ANIM_LINE_1="layerrule = animation slide bottom, rofi"
        NEW_ANIM_LINE_2="layerrule = ignorealpha 0.5, rofi"
        ;;
    "1") # right
        NEW_ANIM_LINE_1="layerrule = animation slide right, rofi"
        NEW_ANIM_LINE_2="layerrule = ignorealpha 0.8, rofi"
        ;;
    "2") # bottom
        NEW_ANIM_LINE_1="layerrule = animation slide bottom, rofi"
        NEW_ANIM_LINE_2="layerrule = ignorealpha 0.8, rofi"
        ;;
    *)
        echo "Use: $0 [0|1|2]"
        exit 1
        ;;
esac

LAST_LINE_NUMBER=$(wc -l < "$HYPR_CONF")
SECOND_LAST_LINE=$((LAST_LINE_NUMBER - 1))

sed -i "${SECOND_LAST_LINE}s|.*|$NEW_ANIM_LINE_1|" "$HYPR_CONF"
sed -i "${LAST_LINE_NUMBER}s|.*|$NEW_ANIM_LINE_2|" "$HYPR_CONF"

hyprctl reload


exit 0