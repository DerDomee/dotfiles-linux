#!/usr/bin/env bash

[[ $(echo -e 'No\nYes' | dmenu -i -p "Exit i3?") == "Yes" ]] && i3-msg exit
