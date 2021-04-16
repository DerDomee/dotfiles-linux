#!/usr/bin/sh

# Terminate all running instances of polybar
killall -q polybar
# Wait for old polybar processes to terminate correctly
while pgrep -u $UID -x polybar >/dev/null; do sleep 1; done
# Start new polybar instances
polybar topbar --config=$HOME/.config/polybar/config 2>&1 | tee -a /tmp/polybar.log & disown;

echo "Bars launched"
