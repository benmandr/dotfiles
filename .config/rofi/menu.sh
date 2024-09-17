#!/bin/bash
WIFI="Wifi"
TRANSLATE="Translate"
CALCULATOR="Calculator"
LOCK="Lock"
SLEEP="Sleep"
SCREENSHOT="Screenshot"
REBOOT="Reboot"
SHUTDOWN="Shutdown"
CLIPBOARD="Clipboard"
START_SCREEN_RECORDING="Start recording"
START_SCREEN_RECORDING_AREA="Start recording (area)"
STOP_SCREEN_RECORDING="Stop recording"

case $ROFI_RETV in
    0 )
        echo -e "$WIFI\0icon\x1fwifi-radar\n"
        echo -e "$TRANSLATE\0icon\x1fgoogle-translate"
        echo -e "$CALCULATOR\0icon\x1fcalc"
        echo -e "$LOCK\0icon\x1flock"
        echo -e "$SLEEP\0icon\x1fsleep"
        echo -e "$REBOOT\0icon\x1fsystem-reboot"
        echo -e "$SHUTDOWN\0icon\x1fsystem-shutdown"
        echo -e "$CLIPBOARD\0icon\x1fclipboard"
        echo -e "$SCREENSHOT\0icon\x1fgnome-screenshot-symbolic"
        echo -e "$START_SCREEN_RECORDING\0icon\x1frecord"
        echo -e "$START_SCREEN_RECORDING_AREA\0icon\x1frecord"
        echo -e "$STOP_SCREEN_RECORDING\0icon\x1fplayer_stop"
        ;;
    1 )
        if [[ "$1" = "$WIFI" ]]; then
            coproc bash ~/.config/rofi/wifi.sh
        elif [[ "$1" = "$TRANSLATE" ]]; then
            coproc bash ~/.config/rofi/translate.sh
        elif [[ "$1" = "$CALCULATOR" ]]; then
            coproc rofi -show calc -modi calc -no-show-match -no-sort
        elif [[ "$1" = "$LOCK" ]]; then
            pkill -x rofi
            exec swaylock -C ~/.config/swaylock/config
        elif [[ "$1" = "$SLEEP" ]]; then
            systemctl suspend
        elif [[ "$1" = "$CONFIRM_SLEEP" ]]; then
            systemctl suspend
        elif [[ "$1" = "$REBOOT" ]]; then
            coproc bash ~/.config/rofi/confirmation.sh "$REBOOT?" "systemctl reboot"
        elif [[ "$1" = "$SHUTDOWN" ]]; then
            coproc bash ~/.config/rofi/confirmation.sh "$SHUTDOWN?" "systemctl poweroff"
        elif [[ "$1" = "$CLIPBOARD" ]]; then
            coproc bash ~/.config/rofi/clipboard.sh
        elif [[ "$1" = "$SCREENSHOT" ]]; then
            pkill -x rofi
            grim -g "$(slurp)" - | swappy -f -
        elif [[ "$1" = "$START_SCREEN_RECORDING" ]]; then
            pkill -x rofi
            nohup wf-recorder -f ~/Videos/recording_$(date +"%Y-%m-%d_%H:%M:%S.mp4") > /dev/null 2>&1 &
        elif  [[ "$1" = "$START_SCREEN_RECORDING_AREA" ]]; then
            pkill -x rofi
            nohup wf-recorder -g "$(slurp)" -f ~/Videos/recording_$(date +"%Y-%m-%d_%H:%M:%S.mp4") > /dev/null 2>&1 &
        elif  [[ "$1" = "$STOP_SCREEN_RECORDING" ]]; then
            pkill -x rofi
            exec killall -s SIGINT wf-recorder
        elif [[ "$1" = "$YES" ]]; then
            if [[ "$ROFI_INFO" = "$CONFIRM_SLEEP" ]]; then
                systemctl suspend
            fi
        elif [[ "$1" = "$NO" ]]; then
            exit 0
        fi
        ;;
    2 ) xdg-open "https://duckduckgo.com/?q=$1"
        coproc swaymsg [app_id="$(xdg-settings get default-web-browser | sed 's/.desktop$//')"] focus
esac