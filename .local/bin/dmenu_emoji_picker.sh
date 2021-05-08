cat ~/.local/bin/emoji_list.txt | dmenu $@ | awk '{print $1;}' | tr -d '\n' | xclip -selection clipboard && xdotool key ctrl+v
