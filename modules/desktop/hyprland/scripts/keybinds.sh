#!/usr/bin/env bash

if pidof rofi >/dev/null; then
	pkill rofi
fi

if pidof yad >/dev/null; then
	pkill yad
fi

HOSTNAME=$(cat /etc/hostname)

get_nix_value() {
	grep "$1" "$HOME/nixos/hosts/$HOSTNAME/options.nix" | sed -E 's/.*"([^"]+)".*/\1/'
}

_terminal=$(get_nix_value "terminal =")
_terminal_FM=$(get_nix_value "terminalFileManager =")
_editor=$(get_nix_value "editor =")
_browser=$(get_nix_value "browser =")

KEYBINDERS=(
	"SUPER Return" "Launch terminal" "$_terminal"
	"SUPER T" "Launch terminal" "$_terminal"
	"SUPER F" "Launch file manager" "$_terminal_FM"
	"SUPER E" "Launch editor" "$_editor"
	"SUPER B" "Launch browser" "$_browser"
	"CTRL ALT Delete" "Open system monitor" "$_terminal -e 'btop'"
	"SUPER A" "Launch application menu" "launcher drun"
	"SUPER SPACE" "Launch application menu" "launcher drun"
	"SUPER F9" "Enable night mode" "hyprsunset --temperature 2500"
	"SUPER F10" "Disable night mode" "pkill hyprsunset"
	"SUPER F8" "Toggle autoclicker" "scripts/autoclicker.nix"
	"SUPER CTRL C" "Colour picker" "hyprpicker --autocopy"
	"SUPER, Left Click" "Move window with mouse" "movewindow"
	"SUPER, Right Click" "Resize window with mouse" "resizewindow"
	"SUPER SHIFT →" "Resize window right" "resizeactive 30 0"
	"SUPER SHIFT ←" "Resize window left" "resizeactive -30 0"
	"SUPER SHIFT ↑" "Resize window up" "resizeactive 0 -30"
	"SUPER SHIFT ↓" "Resize window down" "resizeactive 0 30"
	"SUPER SHIFT L" "Resize window right (HJKL)" "resizeactive 30 0"
	"SUPER SHIFT H" "Resize window left (HJKL)" "resizeactive -30 0"
	"SUPER SHIFT K" "Resize window up (HJKL)" "resizeactive 0 -30"
	"SUPER SHIFT J" "Resize window down (HJKL)" "resizeactive 0 30"
	"XF86MonBrightnessDown" "Decrease brightness" "brightnessctl set 2%-"
	"XF86MonBrightnessUp" "Increase brightness" "brightnessctl set +2%"
	"XF86AudioLowerVolume" "Lower volume" "pamixer -d 2"
	"XF86AudioRaiseVolume" "Increase volume" "pamixer -i 2%"
	"XF86AudioMicMute" "Mute microphone" "pamixer --default-source -t"
	"XF86AudioMute" "Mute audio" "pamixer -t"
	"XF86AudioPlay" "Play/Pause media" "playerctl play-pause"
	"XF86AudioNext" "Next media track" "playerctl next"
	"XF86AudioPrev" "Previous media track" "playerctl previous"
	"SUPER Delete" "Exit Hyprland session" "exit"
	"SUPER W" "Toggle floating window" "togglefloating"
	"SUPER SHIFT G" "Toggle window group" "togglegroup"
	"ALT Return" "Toggle fullscreen" "fullscreen"
	"SUPER ALT L" "Lock screen" "hyprlock"
	"SUPER Backspace" "Power menu" "wlogout -b 4"
	"CTRL Escape" "Toggle Waybar" "pkill waybar || waybar"
	"SUPER SHIFT N" "Open notification panel" "swaync-client -t -sw"
	"SUPER SHIFT Q" "Open notification panel" "swaync-client -t -sw"
	"SUPER Q" "Close active window" "killactive"
	"ALT F4" "Close active window" "killactive"

	"SUPER P" "Screenshot (select area)" "scripts/screenshot.sh s"
	"SUPER CTRL P" "Screenshot (frozen screen)" "scripts/screenshot.sh sf"
	"SUPER Print" "Screenshot (current monitor)" "scripts/screenshot.sh m"
	"SUPER ALT P" "Screenshot (all monitors)" "scripts/screenshot.sh p"
	"SUPER SHIFT CTRL ←" "Move window left" "movewindow l"
	"SUPER SHIFT CTRL →" "Move window right" "movewindow r"
	"SUPER SHIFT CTRL ↑" "Move window up" "movewindow u"
	"SUPER SHIFT CTRL ↓" "Move window down" "movewindow d"
	"SUPER CTRL S" "Move to scratchpad" "movetoworkspacesilent special"
	"SUPER S" "Toggle scratchpad workspace" "togglespecialworkspace"
	"SUPER Tab" "Cycle next window" "cyclenext"
	"SUPER Tab" "Bring active window to top" "bringactivetotop"
	"SUPER CTRL →" "Switch to next workspace" "workspace r+1"
	"SUPER CTRL ←" "Switch to previous workspace" "workspace r-1"
	"SUPER CTRL ↓" "Go to first empty workspace" "workspace empty"
	"SUPER ←" "Move focus left" "movefocus l"
	"SUPER →" "Move focus right" "movefocus r"
	"SUPER ↑" "Move focus up" "movefocus u"
	"SUPER ↓" "Move focus down" "movefocus d"
	"ALT Tab" "Move focus down" "movefocus d"
	"SUPER 1-0" "Switch to workspace 1-10" "workspace 1-10"
	"SUPER SHIFT 1-0" "Move to workspace 1-10" "movetoworkspace 1-10"

	"SUPER R" "Random wallpapers" "scripts/random-walls.sh"
	"SUPER ALT K" "Change keyboard layout" "scripts/keyboard-switch.sh"
	"SUPER U" "Rebuild system" "$_terminal -e scripts/rebuild.sh"
	"SUPER V" "Clipboard manager" "scripts/clip-manager.sh"
)

if grep -E '^[^#]*rofi-rbw *= *true;' "$HOME/nixos/hosts/$HOSTNAME/options.nix" >/dev/null; then
	RBW_ROFI=true
else
	RBW_ROFI=false
fi

if [ "$RBW_ROFI" = "true" ]; then
	KEYBINDERS+=(
		"SUPER SHIFT U" "Password manager" "launcher rbw"
	)
fi

if grep -E '^[^#]*modules/programs/gui/games' "$HOME/nixos/hosts/$HOSTNAME/configuration.nix" >/dev/null; then
	GAME_LAUNCHER=true
else
	GAME_LAUNCHER=false
fi

if [ "$GAME_LAUNCHER" = true ]; then
	KEYBINDERS+=(
		"SUPER G" "Game launcher" "launcher games"
		"SUPER ALT G" "Enable game mode" "scripts/gamemode.sh"
	)
fi

yad --center \
	--title="Hyprland Keybinds" \
	--no-buttons \
	--list \
	--width=745 \
	--height=920 \
	--column=Key: --column=Description: --column=Command: \
	--timeout-indicator=bottom \
	"${KEYBINDERS[@]}"
