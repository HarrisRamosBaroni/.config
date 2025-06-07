#!/bin/bash

LOG_FILE="/tmp/aerospace_sketchybar_updater.log"
echo "----------------------------------------" >> "$LOG_FILE"
date >> "$LOG_FILE"
echo "Script triggered." >> "$LOG_FILE"
echo "AEROSPACE_FOCUSED_WORKSPACE: '${AEROSPACE_FOCUSED_WORKSPACE}'" >> "$LOG_FILE"

# Attempt to find commands in a common path, or use absolute paths if known
SKETCHYBAR_CMD="sketchybar"
AEROSPACE_CMD="aerospace"

# Check if commands exist in PATH, otherwise user might need to set absolute paths here
if ! command -v $SKETCHYBAR_CMD >/dev/null; then
    echo "sketchybar command not found in PATH, consider setting absolute path for SKETCHYBAR_CMD" >> "$LOG_FILE"
    # SKETCHYBAR_CMD="/opt/homebrew/bin/sketchybar" # Example for Homebrew
fi
if ! command -v $AEROSPACE_CMD >/dev/null; then
    echo "aerospace command not found in PATH, consider setting absolute path for AEROSPACE_CMD" >> "$LOG_FILE"
    # AEROSPACE_CMD="/opt/homebrew/bin/aerospace" # Example for Homebrew
fi

FOCUSED_WORKSPACE="${AEROSPACE_FOCUSED_WORKSPACE}"
if [ -z "$FOCUSED_WORKSPACE" ]; then
    echo "AEROSPACE_FOCUSED_WORKSPACE is empty, trying CLI fallback." >> "$LOG_FILE"
    FOCUSED_WORKSPACE_CLI_OUTPUT=$($AEROSPACE_CMD list-workspaces --focused 2>&1)
    echo "Fallback CLI output: $FOCUSED_WORKSPACE_CLI_OUTPUT" >> "$LOG_FILE"
    FOCUSED_WORKSPACE=$(echo "$FOCUSED_WORKSPACE_CLI_OUTPUT" | head -n 1)
fi
echo "Determined FOCUSED_WORKSPACE: '${FOCUSED_WORKSPACE}'" >> "$LOG_FILE"

ALL_WORKSPACES=("1" "2" "3" "4")
echo "ALL_WORKSPACES: ${ALL_WORKSPACES[*]}" >> "$LOG_FILE"

HIGHLIGHT_BG_COLOR="0xcc527080"
HIGHLIGHT_BORDER_COLOR="0xff77aadd"
DEFAULT_BG_COLOR="0x40ffffff"
ICON_COLOR="0xffffffff"

for ws_num in "${ALL_WORKSPACES[@]}"; do
    item_name="aerospace_ws_$ws_num"
    echo "Processing $item_name for ws_num $ws_num" >> "$LOG_FILE"
    if [ "$ws_num" = "$FOCUSED_WORKSPACE" ]; then
        echo "Highlighting $item_name" >> "$LOG_FILE"
        $SKETCHYBAR_CMD --set "$item_name" \
                   icon.color="$ICON_COLOR" \
                   background.color="$HIGHLIGHT_BG_COLOR" \
                   background.border_color="$HIGHLIGHT_BORDER_COLOR" \
                   background.border_width=2 \
                   shadow=off >> "$LOG_FILE" 2>&1
    else
        echo "Setting default for $item_name" >> "$LOG_FILE"
        $SKETCHYBAR_CMD --set "$item_name" \
                   icon.color="$ICON_COLOR" \
                   background.color="$DEFAULT_BG_COLOR" \
                   background.border_color="$DEFAULT_BG_COLOR" \
                   background.border_width=0 \
                   shadow=off >> "$LOG_FILE" 2>&1
    fi
done
echo "Script finished." >> "$LOG_FILE"