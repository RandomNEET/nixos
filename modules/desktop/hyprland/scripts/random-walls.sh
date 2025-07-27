#!/usr/bin/env bash

# Wallpaper directories
HORIZONTAL_WALLPAPER_DIR="$HOME/pic/wallpapers/horizontal/"
VERTICAL_WALLPAPER_DIR="$HOME/pic/wallpapers/vertical/"

# Get all monitor information
MONITORS=$(hyprctl monitors -j | jq -c '.[]')

# Iterate through all monitors
while read -r MONITOR; do
	NAME=$(echo "$MONITOR" | jq -r '.name')
	TRANSFORM=$(echo "$MONITOR" | jq -r '.transform')

	# Select wallpaper directory based on transform
	if [[ $((TRANSFORM % 2)) -eq 0 ]]; then
		WALLPAPER_DIR="$HORIZONTAL_WALLPAPER_DIR"
	else
		WALLPAPER_DIR="$VERTICAL_WALLPAPER_DIR"
	fi

	# Get a random wallpaper
	WALLPAPER=$(find "$WALLPAPER_DIR" -type f | shuf -n 1)

	# Ensure a wallpaper file is found
	if [[ -f "$WALLPAPER" ]]; then
		# Preload wallpaper
		hyprctl hyprpaper preload "$WALLPAPER"
		# Apply wallpaper
		hyprctl hyprpaper wallpaper "$NAME,$WALLPAPER"
	fi
done <<<"$MONITORS"
