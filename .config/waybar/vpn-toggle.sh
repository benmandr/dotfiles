#!/bin/bash

if [ "$(nordvpn status | grep -c "Connected")" -eq 1 ]; then
    nordvpn disconnect
else
    nordvpn connect
fi

# Force waybar to refresh the VPN module
pkill -RTMIN+8 waybar
