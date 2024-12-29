#!/bin/bash
max_retries=5
delay=10

check_connectivity() {
    ping -q -c 1 -W 1 8.8.8.8 >/dev/null
    return $?
}

for ((i=1; i<=max_retries; i++)); do
    if check_connectivity; then
        weather=$(curl -s "wttr.in/Kaunas?format=1&m")

        if [ "$weather" = "This query is already being processed" ]; then
            echo ""
        fi

        echo "${weather}"
        exit 0
    fi
    sleep $delay
done
