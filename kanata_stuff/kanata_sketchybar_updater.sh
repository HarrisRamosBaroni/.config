#!/bin/bash
# This script runs `kanata-tray-macos` and parses its output for layer changes.

sudo kanata-tray-macos | while read -r line; do
    # Look for lines indicating layer changes
    if [[ "$line" =~ Setting\ icon:\ preset:\*,\ layer:([^[:space:]]+) ]]; then
        # Extract the layer name from the line
        LAYER="${BASH_REMATCH[1]}"

        # Update SketchyBar based on the detected layer
        case "$LAYER" in
            "normal")
                sketchybar --set layer_indicator label="Home" label.color=0xffc0c0c0
                ;;
            "bookmarks")
                sketchybar --set layer_indicator label="Bookmarks" label.color=0xff0099ff
                ;;
            "visual")
                sketchybar --set layer_indicator label="Visual" label.color=0xff33cc33
                ;;
            "numbers2")
                sketchybar --set layer_indicator label="Numbers" label.color=0xffcc2900
                ;;
            "*")
                sketchybar --set layer_indicator label="Insert" label.color=0xffffffff
                ;;
            *)
                sketchybar --set layer_indicator label="Unknown"
                ;;
        esac
    fi
done