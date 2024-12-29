#!/bin/bash
if [ "$(nordvpn status | grep "Connected" | wc -l)" -eq 1 ]; then
    echo " 󰖂  "
else
    echo ""
fi

exit 0