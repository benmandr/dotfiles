#!/bin/bash
max_retries=3
retry_count=0

until curl --output /dev/null --silent --head --fail "wttr.in/?format=%c%t"; do
    retry_count=$((retry_count + 1))

    if [ $retry_count -ge $max_retries ]; then
        exit 1
    fi

    sleep 5
done

weather=$(curl -s "wttr.in/?format=%c%t")

echo ${weather::-1}
