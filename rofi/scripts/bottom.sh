#!/usr/bin/env bash

source /home/$USER/.custom/general.sh

theme='bottom'

# CMDs
uptime="`uptime -p | sed -e 's/up //g'`"
host=`hostname`

# Options
wall1=''
wall2=''
wall3=''
wall4=''

run_rofi() {
	echo -e "$wall1\n$wall2\n$wall3\n$wall4"
}
${hypr_scripts_dir}/changeanim.sh 2
chosen="$(run_rofi | rofi -dmenu -theme ${rofi_dir}/${theme}.rasi)"

case ${chosen} in
    $wall1)
		$hypr_scripts_dir/wallpaper.sh 1
        ;;
    $wall2)
		$hypr_scripts_dir/wallpaper.sh 2
        ;;
    $wall3)
		$hypr_scripts_dir/wallpaper.sh 3
        ;;
    $wall4)
		$hypr_scripts_dir/wallpaper.sh 4
        ;;
esac
