#!/usr/bin/env bash

ICON="cloud-sync"
TITLE="MEGA Sync"
STATE_DIR="$HOME/.cache/mega-health"
LOG_FILE="$STATE_DIR/mega.log"

mkdir -p "$STATE_DIR"

notify() {
    notify-send -i "$ICON" "$TITLE" "$1"
}

notify_critical() {
    notify-send -u critical -i "$ICON" "$TITLE" "$1"
}

log() {
    echo "[$(date --iso-8601=seconds)] $1" >> "$LOG_FILE"
}

# --- 1. Login check ---
if ! mega-whoami &>/dev/null; then
    notify_critical "Not logged in to MEGA."
    log "Not logged in"
    exit 1
fi

# --- 2. Sync status ---
SYNC_OUTPUT="$(mega-sync 2>/dev/null)"
TRANSFER_OUTPUT="$(mega-transfers 2>/dev/null)"

ISSUES=""
ACTIVE_TRANSFERS=0

# Detect sync issues
while read -r ID LOCAL REMOTE RUN_STATE STATUS ERROR REST; do
    # Skip header or empty lines
    [[ "$ID" == "ID" || -z "$ID" ]] && continue

    if [[ "$STATUS" != "Synced" ]]; then
        ISSUES+="\n• Sync not synced (status: $STATUS)"
    fi

    if [[ "$ERROR" != "NO" ]]; then
        ISSUES+="\n• Sync error reported"
    fi
done < <(echo "$SYNC_OUTPUT")

# Detect transfer problems
if echo "$TRANSFER_OUTPUT" | grep -qi "FAILED"; then
    ISSUES+="\n• Failed transfer(s)"
fi

if echo "$TRANSFER_OUTPUT" | grep -qi "STALLED"; then
    ISSUES+="\n• Stalled transfer(s)"
fi

# Count active transfers
ACTIVE_TRANSFERS=$(echo "$TRANSFER_OUTPUT" | grep -ciE "UPLOAD|DOWNLOAD")

# --- 3. State files ---
ISSUE_STATE="$STATE_DIR/issues"
TRANSFER_STATE="$STATE_DIR/transfers"

# --- 4. Notify on issues (state-aware) ---
if [[ -n "$ISSUES" ]]; then
    LAST_ISSUES="$(cat "$ISSUE_STATE" 2>/dev/null)"

    if [[ "$LAST_ISSUES" != "$ISSUES" ]]; then
        notify_critical "Problems detected:$ISSUES"
        log "Issues: $ISSUES"
        echo "$ISSUES" > "$ISSUE_STATE"
    fi
else
    rm -f "$ISSUE_STATE"
fi

# --- 5. Notify on transfer changes ---
LAST_TRANSFERS="$(cat "$TRANSFER_STATE" 2>/dev/null)"

if [[ "$ACTIVE_TRANSFERS" -gt 0 ]]; then
    if [[ "$LAST_TRANSFERS" != "$ACTIVE_TRANSFERS" ]]; then
        notify "Active transfers: $ACTIVE_TRANSFERS"
        log "Active transfers: $ACTIVE_TRANSFERS"
        echo "$ACTIVE_TRANSFERS" > "$TRANSFER_STATE"
    fi
else
    # Transfers finished
    if [[ "$LAST_TRANSFERS" -gt 0 ]]; then
        notify "All sync transfers finished ✅"
        log "Transfers finished"
    fi
    rm -f "$TRANSFER_STATE"
fi
