#!/bin/bash

pactl subscribe | while read -r event; do
    if echo "$event" | grep -q "Event 'remove' on sink"; then
        sinks=$(pactl list short sinks)
        
        if ! echo "$sinks" | grep -q "bluez"; then
            playerctl stop
        fi
    fi
done
