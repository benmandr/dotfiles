#!/bin/bash

if [ "$(nordvpn status | grep "Connected" | wc -l)" -eq 1 ]; then
    location=$(nordvpn status | grep "Server" | awk '{print $2}')
    echo "{\"text\":\" 󰖂  \" , \"tooltip\":\"Connected to $location\", \"class\":\"connected\"}"
else
    echo "{\"text\":\" 󰖂  \" , \"class\":\"disconnected\"}"
fi

exit 0