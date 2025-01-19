#!/bin/bash

# Get initial CPU stats
initial=$(grep 'cpu ' /proc/stat)
sleep 1
# Get CPU stats after 1 second
final=$(grep 'cpu ' /proc/stat)

# Calculate the difference
initial_idle=$(echo "$initial" | awk '{print $5}')
initial_total=$(echo "$initial" | awk '{for(i=2;i<=NF;i++) sum+=$i; print sum}')
final_idle=$(echo "$final" | awk '{print $5}')
final_total=$(echo "$final" | awk '{for(i=2;i<=NF;i++) sum+=$i; print sum}')

# Calculate CPU usage
idle_diff=$((final_idle - initial_idle))
total_diff=$((final_total - initial_total))
usage=$((100 * (total_diff - idle_diff) / total_diff))

# Prepare tooltip
tooltip=$(~/.config/waybar/top-cpu-processes.sh)

# Escape newlines and quotes for JSON
tooltip_escaped=$(echo "$tooltip" | sed 's/"/\\"/g' | sed ':a;N;$!ba;s/\n/\\n/g')

# Output JSON
printf '{"text": "%d%%", "tooltip": "%s", "class": "%s"}\n' \
    "$usage" \
    "$tooltip_escaped" \
    "$([ $usage -gt 80 ] && echo warning)"
