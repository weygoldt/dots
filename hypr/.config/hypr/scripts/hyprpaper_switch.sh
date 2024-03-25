#!/bin/bash

directory=~/.dotfiles/hypr/.config/hypr/wallpapers
filetypes = "*.jpg *.png *.jpeg"

for monitor in $(hyprctl monitors | rg "Monitor" | awk '{print $2}'); do
    echo "Setting wallpaper for monitor $monitor"
    if [ -d "$directory" ]; then
        random_background=$(ls $directory/*jpg | shuf -n 1)
        echo "Setting wallpaper to $random_background"

        hyprctl hyprpaper unload all
        hyprctl hyprpaper preload $random_background
        hyprctl hyprpaper wallpaper "$monitor, $random_background"

    fi
done
