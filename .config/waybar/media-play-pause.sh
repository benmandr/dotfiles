#!/bin/bash
status=$(playerctl status)

if [ "$status" == "Playing" ]; then
    echo ""
elif [ "$status" == "Paused" ]; then
    echo ""
fi

exit 0
