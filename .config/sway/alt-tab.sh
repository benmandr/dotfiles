#!/usr/bin/env bash  
swaymsg "unbindsym "Mod4+Tab""

recently_focused_window_id=($(cat "$HOME/.config/sway/most-recently-focused-window-ids"))
all_window_ids=$(swaymsg -t get_tree | jq -r '..
    | objects | select(.type == "workspace") as $ws | .. | objects
    | select(has("app_id")) | (.app_id // .window_properties.class // .name) as $icon_name
    | (.id) as $id | "\($id) \($icon_name)icon-\($icon_name)"
')
id_map=$(echo "$all_window_ids" | awk '{print $2 " " $1}')
result=$(echo "$all_window_ids" | awk -v id="$recently_focused_window_id" '
BEGIN {focused_found = 0}
{
    if ($1 == id) {
        print $2, $3
        focused_found = 1
    } else {
        buffer[NR] = $2" "$3
    }
}
END {
    for (i = 1; i <= NR; i++) {
        if (buffer[i] != "") print buffer[i]
    }
}' | awk 'NF')
replaced_icons=$(echo "$result" | while read -r line; do
  echo "${line/icon-/\\0icon\\x1f}"
done)

selected=$(echo -e "$replaced_icons" | rofi -dmenu  rofi -dmenu -kb-accept-entry '!Super_L' -kb-row-down 'Super_L+Tab' -kb-row-up 'Super_L+ISO_Left_Tab')
app_name=$(echo "$selected" | awk '{print $1}')
window_id=$(echo "$id_map" | awk -v app="$app_name" '$1 ~ app {print $2}')
window_id=$(echo "$window_id" | xargs)
if [ -n "$window_id" ]; then
    swaymsg "[con_id=$window_id] focus"
fi

swaymsg "bindsym Mod4+Tab exec ~/.config/sway/alt-tab.sh"

exit