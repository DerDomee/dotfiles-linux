#!/usr/bin/env bash

case $(echo -e "shutdown\nreboot\nlogout" | dmenu -c -r -F -l 3 -p "What to do?!") in
	"shutdown") shutdown now;;
	"reboot") reboot now;;
	"logout") i3-msg exit;;
	*) exit;;
esac
