#!/usr/bin/env bash
# check if rofi is already running
if pidof rofi >/dev/null; then
	pkill rofi
	exit 0
fi

rofi_theme="${XDG_CONFIG_HOME:-$HOME/.config}/rofi/launchers/type-1/style-6.rasi"

rofi-rbw --selector rofi --selector-args="-theme $rofi_theme"
