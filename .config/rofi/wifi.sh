#!/bin/bash
# Get a list of available wifi connections and morph it into a nice-looking list
wifi_list=$(nmcli --fields "SECURITY,SSID" device wifi list | sed 1d | sed 's/  */ /g' | sed -E "s/WPA*.?\S/ /g" | sed "s/^--/ /g" | sed "s/  //g" | sed "/--/d")

connected=$(nmcli -fields WIFI g)
if [[ "$connected" =~ "enabled" ]]; then
	toggle="󰖪  Disable Wi-Fi"
elif [[ "$connected" =~ "disabled" ]]; then
	toggle="󰖩  Enable Wi-Fi"
fi

# Use rofi to select wifi network
chosen_network=$(echo -e "$toggle\n$wifi_list" | rofi -dmenu -i -selected-row 1 -p "Wi-Fi SSID: " )
# Get name of connection
read -r chosen_id <<< "${chosen_network:3}"

if [ "$chosen_network" = "" ]; then
	exit
elif [ "$chosen_network" = "󰖩  Enable Wi-Fi" ]; then
	nmcli radio wifi on
elif [ "$chosen_network" = "󰖪  Disable Wi-Fi" ]; then
	nmcli radio wifi off
else
	# Get saved connections
	saved_connections=$(nmcli -g NAME connection)
	if [[ $(echo "$saved_connections" | grep -w "$chosen_id") = "$chosen_id" ]]; then
		nmcli connection up id "$chosen_id" | grep "successfully"
	else
		if [[ "$chosen_network" =~ "" ]]; then
			wifi_password=$(rofi -dmenu -p "Password: " )
		fi
		nmcli device wifi connect "$chosen_id" password "$wifi_password" | grep "successfully"
    fi
fi