#!/usr/bin/env bash

STATE_DIR="$HOME/.cache/mega-health"
ISSUE_FILE="$STATE_DIR/issues"
TRANSFER_FILE="$STATE_DIR/transfers"
LOG_FILE="$STATE_DIR/mega.log"

# Defaults
TEXT="MEGA"
CLASS="idle"
TOOLTIP="MEGA sync idle"

# Logged out
if ! mega-whoami &>/dev/null; then
    TEXT="MEGA ⛔"
    CLASS="loggedout"
    TOOLTIP="Not logged in to MEGA"
else
    if [[ -f "$ISSUE_FILE" ]]; then
        TEXT="MEGA 🔴"
        CLASS="error"
        TOOLTIP="$(cat "$ISSUE_FILE")"
    elif [[ -f "$TRANSFER_FILE" ]]; then
        COUNT="$(cat "$TRANSFER_FILE")"
        TEXT="MEGA 🔄 $COUNT"
        CLASS="syncing"
        TOOLTIP="Active transfers: $COUNT"
    else
        TEXT="MEGA 🟢"
        CLASS="ok"
        TOOLTIP="All files are synced"
    fi
fi

# Output JSON
printf '{"text":"%s","class":"%s","tooltip":"%s"}\n' \
  "$TEXT" "$CLASS" "$TOOLTIP"
