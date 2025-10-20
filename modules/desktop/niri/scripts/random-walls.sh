#!/usr/bin/env bash
set -euo pipefail

# Wallpaper directories - change to your actual paths
HORIZONTAL_WALLPAPER_DIR="$HOME/pic/wallpapers/horizontal/"
VERTICAL_WALLPAPER_DIR="$HOME/pic/wallpapers/vertical/"

# Command dependencies check
command -v niri >/dev/null 2>&1 || {
	echo "niri not found in PATH"
	exit 1
}
command -v swaybg >/dev/null 2>&1 || {
	echo "swaybg not found in PATH"
	exit 1
}
command -v shuf >/dev/null 2>&1 || {
	echo "shuf not found in PATH"
	exit 1
}

# Optional: terminate existing swaybg instances to avoid duplicates
pkill -x swaybg >/dev/null 2>&1 || true

pick_random_file() {
	local dir="$1"
	# Use -print0 and shuf -z to safely handle filenames with spaces/newlines
	find "$dir" -type f -print0 2>/dev/null | shuf -z -n 1 | tr -d '\0' || true
}

process_monitor() {
	local short_name="$1"
	local width="$2"
	local height="$3"
	local transform="$4"

	# Normalize empty values
	width="${width:-0}"
	height="${height:-0}"
	transform="${transform:-normal}"

	# If transform mentions 90 or 270 (or rot90/rot270/etc.), consider it rotated and swap width/height
	local rotated=false
	if [[ "$transform" =~ 90|270|rot90|rot270|right|left ]]; then
		rotated=true
	fi

	local test_w="$width"
	local test_h="$height"
	if [[ "$rotated" == true ]]; then
		test_w="$height"
		test_h="$width"
	fi

	# Choose directory by orientation (landscape -> horizontal, portrait -> vertical)
	local wallpaper_dir="$HORIZONTAL_WALLPAPER_DIR"
	if [[ -n "$test_w" && -n "$test_h" && "$test_w" != "0" && "$test_h" != "0" && "$test_w" -lt "$test_h" ]]; then
		wallpaper_dir="$VERTICAL_WALLPAPER_DIR"
	fi

	local wallpaper
	wallpaper="$(pick_random_file "$wallpaper_dir")"

	if [[ -n "$wallpaper" && -f "$wallpaper" ]]; then
		# Start a swaybg process per output in the background; mode can be changed (fill/fit/scale/center/tile)
		swaybg -o "$short_name" -i "$wallpaper" -m fill &
		echo "Set wallpaper for output $short_name -> $wallpaper"
	else
		echo "No wallpaper found for output $short_name in $wallpaper_dir" >&2
	fi
}

# Parse `niri msg outputs` output.
# Expected block format:
# Output "Full Name" (SHORTNAME)
#   ...
#   Logical size: 1536x864
#   Transform: normal
current_name=""
current_short=""
current_width=""
current_height=""
current_transform=""

# Read niri output line-by-line and parse
niri msg outputs | while IFS= read -r line || [[ -n "$line" ]]; do
	# Match output line: Output "Full Name" (SHORTNAME)
	if [[ $line =~ ^Output\ \"(.*)\"\ \(([^\)]*)\) ]]; then
		# If we already have an unprocessed output, process it first
		if [[ -n "$current_short" ]]; then
			process_monitor "$current_short" "$current_width" "$current_height" "$current_transform"
		fi

		current_name="${BASH_REMATCH[1]}"
		current_short="${BASH_REMATCH[2]}"
		current_width=""
		current_height=""
		current_transform=""
		continue
	fi

	# Match Logical size: 1536x864
	if [[ $line =~ Logical\ size:\ ([0-9]+)x([0-9]+) ]]; then
		current_width="${BASH_REMATCH[1]}"
		current_height="${BASH_REMATCH[2]}"
		continue
	fi

	# Match Transform: normal
	if [[ $line =~ Transform:\ (.*) ]]; then
		current_transform="$(echo "${BASH_REMATCH[1]}" | sed 's/^[[:space:]]*//;s/[[:space:]]*$//')"
		continue
	fi

	# An empty line signals the end of a block; process the accumulated output
	if [[ -z "${line//[[:space:]]/}" ]]; then
		if [[ -n "$current_short" ]]; then
			process_monitor "$current_short" "$current_width" "$current_height" "$current_transform"
			current_name=""
			current_short=""
			current_width=""
			current_height=""
			current_transform=""
		fi
	fi
done

# After loop, process any remaining unprocessed output
if [[ -n "$current_short" ]]; then
	process_monitor "$current_short" "$current_width" "$current_height" "$current_transform"
fi

# Optionally wait if you want the script to remain running while swaybg processes run:
# wait
