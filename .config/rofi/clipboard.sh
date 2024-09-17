#!/bin/bash
nohup cliphist list | rofi -dmenu | cliphist decode | wl-copy