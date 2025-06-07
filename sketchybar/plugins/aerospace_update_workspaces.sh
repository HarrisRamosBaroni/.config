#!/bin/bash

# Get the currently focused AeroSpace workspace (provided by AeroSpace's exec-on-workspace-change)
# or fall back to querying AeroSpace directly.
FOCUSED_WORKSPACE="${AEROSPACE_FOCUSED_WORKSPACE:-$(aerospace list-workspaces --focused | head -n 1)}"

# Define all expected AeroSpace workspaces
ALL_WORKSPACES=("1" "2" "3" "4")

# Define colors/styles for SketchyBar items
HIGHLIGHT_BG_COLOR="0xcc527080"
HIGHLIGHT_BORDER_COLOR="0xff77aadd"
DEFAULT_BG_COLOR="0x40ffffff"
ICON_COLOR="0xffffffff"

for ws_num in "${ALL_WORKSPACES[@]}"; do
    item_name="aerospace_ws_$ws_num"
    if [ "$ws_num" = "$FOCUSED_WORKSPACE" ]; then
        sketchybar --set "$item_name" \
                   icon.color="$ICON_COLOR" \
                   background.color="$HIGHLIGHT_BG_COLOR" \
                   background.border_color="$HIGHLIGHT_BORDER_COLOR" \
                   background.border_width=2 \
                   shadow=off
    else
        sketchybar --set "$item_name" \
                   icon.color="$ICON_COLOR" \
                   background.color="$DEFAULT_BG_COLOR" \
                   background.border_color="$DEFAULT_BG_COLOR" \
                   background.border_width=0 \
                   shadow=off
    fi
done