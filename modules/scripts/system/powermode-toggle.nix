{
  config,
  pkgs,
  opts,
  ...
}:
if config.services.power-profiles-daemon.enable then
  pkgs.writeShellScriptBin "powermode-toggle" ''
    MODE_FILE="$HOME/.config/hypr/power_mode"

    if [[ ! -s "$MODE_FILE" ]]; then
    	echo "performance" >"$MODE_FILE"
    fi

    CURRENT=$(cat "$MODE_FILE")

    if [[ "$CURRENT" == "performance" ]]; then
    	NEW_MODE="powersave"
    	CMD="powerprofilesctl set power-saver"
    else
    	NEW_MODE="performance"
    	CMD="powerprofilesctl set performance"
    fi

    if $CMD >/dev/null 2>&1; then
    	echo "$NEW_MODE" >"$MODE_FILE"
    fi

    exit 0
  ''
else if config.services.tlp.enable then
  pkgs.writeShellScriptBin "powermode-toggle" ''
    MODE_FILE="$HOME/.config/hypr/power_mode"

    if [[ ! -s "$MODE_FILE" ]]; then
        echo "performance" > "$MODE_FILE"
    fi

    CURRENT=$(cat "$MODE_FILE")

    if [[ "$CURRENT" == "performance" ]]; then
        NEW_MODE="powersave"
        CMD="pkexec tlp bat"
    else
        NEW_MODE="performance"
        CMD="pkexec tlp ac"
    fi

    if $CMD > /dev/null 2>&1; then
        echo "$NEW_MODE" > "$MODE_FILE"
    fi

    exit 0
  ''
else
  null
