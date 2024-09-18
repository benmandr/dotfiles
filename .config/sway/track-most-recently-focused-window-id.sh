#!/bin/bash
FOCUS_FILE="$HOME/.config/sway/most-recently-focused-window-ids"

swaymsg -t subscribe -m '[ "window" ]' | while read -r event; do
    if echo "$event" | grep -q '"change": "focus"'; then
        current_focused_window_id=$(swaymsg -t get_tree | jq -r 'recurse(.nodes[]?) | select(.focused == true) | .id')
        last_focused_window_id=$(tail -n 1 "$FOCUS_FILE" 2>/dev/null || echo "")
        if [ "$current_focused_window_id" != "$last_focused_window_id" ]; then     
            echo "$current_focused_window_id" >> "$FOCUS_FILE"
            tail -n 2 "$FOCUS_FILE" > "$FOCUS_FILE.tmp" && mv "$FOCUS_FILE.tmp" "$FOCUS_FILE"
        fi
    fi
done
