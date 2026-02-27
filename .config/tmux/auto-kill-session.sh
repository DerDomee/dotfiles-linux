#!/usr/bin/env bash

SESSION="$1"

# noch Clients attached?
clients=$(tmux list-clients -t "$SESSION" 2>/dev/null | wc -l)

if [ "$clients" -gt 0 ]; then
    exit 0
fi

# alle Pane-PIDs holen
pids=$(tmux list-panes -t "$SESSION" -F "#{pane_pid}")

for pid in $pids; do
    # läuft mehr als nur die Shell?
    children=$(pgrep -P "$pid")

    if [ -n "$children" ]; then
        exit 0
    fi
done

# If script passes until here, conditions are met
# to kill this session.
tmux kill-session -t "$SESSION"

# After killing the session, creating it anew, so
# the shell is pre-warmed and instantly ready on re-attaching.
# Doing this asynchronously to prevent race conditions with
# this very same hook not being able to create a new session
# while still being busy with deleting it
(
    sleep 0.2
    tmux new-session -d -s "$SESSION"
) &
