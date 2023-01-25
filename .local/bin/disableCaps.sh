#!/usr/bin/bash

caps_lock_status=$(xset -q | sed -n 's/^.*Caps Lock:\s*\(\S*\).*$/\1/p')
if [ $caps_lock_status == "on" ]; then
  echo "Caps lock on, turning off"
  xdotool key Caps_Lock
else
  echo "Caps lock already off"
fi

