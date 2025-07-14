#!/usr/bin/env bash

# Check if script is run in an interactive shell
if [ -t 0 ]; then
    sudo efibootmgr --bootnext 0000 --quiet
    sudo reboot now
else
    password=$(ksshaskpass "Enter sudo password:")
    echo "$password" | sudo -S efibootmgr --bootnext 0000 --quiet
    echo "$password" | sudo -S reboot now
fi
