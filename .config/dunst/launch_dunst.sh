#!/usr/bin/sh

# Terminate all running instances of polybar
killall -q dunst
# Wait for old polybar processes to terminate correctly
while pgrep -u $UID -x dunst >/dev/null; do sleep 1; done
# Start new polybar instances
dunst -config "$HOME/.config/dunst/config" &
echo "Dunst launched"

