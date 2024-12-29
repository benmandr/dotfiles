#!/bin/bash
status=$(playerctl status)
status_icon=""

if [ "$status" == "Playing" ]; then
    status_icon=""
elif [ "$status" == "Paused" ]; then
    status_icon=""
fi

echo "    $(playerctl metadata --format '{{artist}} - {{title}}')   ${status_icon}"

exit 0
