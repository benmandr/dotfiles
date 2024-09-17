#!/bin/bash
text=$(rofi -dmenu)

while [ "$text" != "" ] 
do
    text=$(trans -brief "$text" | rofi -dmenu)
done