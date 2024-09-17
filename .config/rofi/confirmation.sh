#!/bin/bash
# First argument - title of the confirmation dialog
# Second argument - command in string format to be executed on confirmation
YES="Yes"
NO="No"
choice=$(echo -e "$NO\0icon\x1fadvert-block\n$YES\0icon\x1fcheckmark" | rofi -dmenu -mesg "$1")

if [[ "$choice" = "Yes" ]]; then
    eval "$2"
fi