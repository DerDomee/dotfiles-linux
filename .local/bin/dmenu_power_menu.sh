#!/usr/bin/env bash

case $(echo -e "shutdown\nreboot\nlogout" | dmenu -c -l 3) in
	"shutdown") shutdown now;;
	"reboot") reboot now;;
	"logout") i3-msg exit;;
	*) echo "ERROR!";;
esac
