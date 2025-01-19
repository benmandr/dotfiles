#!/bin/bash
ps -eo comm,%cpu --sort=-%cpu | awk -v cores="$(nproc)" '
    # Skip header
    NR>1 {
        cpu = $2 / cores
        name = $1
        # Sum CPU for same process
        cpus[name] += cpu
        # Keep track of process names
        if (!(name in seen)) {
            seen[name] = 1
            names[++count] = name
        }
    }
    END {
        # Sort processes by CPU usage
        for (i = 1; i <= count; i++) {
            for (j = i + 1; j <= count; j++) {
                if (cpus[names[i]] < cpus[names[j]]) {
                    temp = names[i]
                    names[i] = names[j]
                    names[j] = temp
                }
            }
        }
        
        # Print processes in compact format
        for (i = 1; i <= 5 && i <= count; i++) {
            name = names[i]
            if (cpus[name] > 0.1) {
                printf "<tt><span color=\"#cba6f7\">%-16s</span><span color=\"#94e2d5\">%6.1f%%</span></tt>\n", 
                       substr(name,1,16), 
                       cpus[name]
            }
        }
    }
'
