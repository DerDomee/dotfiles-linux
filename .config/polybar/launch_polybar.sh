#!/usr/bin/sh

# Terminate all running instances of polybar
killall -q polybar
# Wait for old polybar processes to terminate correctly
while pgrep -u $UID -x polybar >/dev/null; do sleep 1; done
# Start new polybar instances

for m in $@; do
		polybar $m --config=$HOME/.config/polybar/config.ini 2>&1 | tee -a /tmp/polybar.log & disown;
done

echo "Bars launched"
