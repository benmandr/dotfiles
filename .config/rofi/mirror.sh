#!/bin/bash
exec wl-mirror -F eDP-1 &
sleep 0.5
swaymsg [app_id="at.yrlf.wl_mirror"] move container to output DP-1
swaymsg [app_id="at.yrlf.wl_mirror"] move container to output HDMI-A-2