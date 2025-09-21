#! /bin/bash

# Simple cleanup
trap 'pkill -P $$; exit 0' EXIT TERM INT

# Create a basic config
cat > /tmp/cava_config << EOF
[general]
bars = 9
framerate = 60

[input]
method = pulse

[output]
method = raw
raw_target = /dev/stdout
data_format = ascii
ascii_max_range = 7
channels = mono
EOF

# Define the bar characters
bar="▁▂▃▄▅▆▇█"
dict="s/;//g;"

# creating "dictionary" to replace char with bar
i=0
while [ $i -lt ${#bar} ]
do
    dict="${dict}s/$i/${bar:$i:1}/g;"
    i=$((i=i+1))
done

# Run cava and transform output
cava -p /tmp/cava_config | while read -r line; do
    echo "$line" | sed "$dict"
done