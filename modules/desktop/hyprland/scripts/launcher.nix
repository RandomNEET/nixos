{
  config,
  lib,
  pkgs,
  opts,
  ...
}:
let
  terminal = opts.terminal;
  displays = opts.display or [ ];
  wallpaperDir = opts.wallpaper.dir or "${config.users.users.${opts.username}.home}/pic/wallpapers";
  landscapeDir = opts.wallpaper.landscapeDir or "${wallpaperDir}/landscape";
  portraitDir = opts.wallpaper.portraitDir or "${wallpaperDir}/portrait";
  transitionType = opts.wallpaper.transition.type or "center";
  transitionStep = toString (opts.wallpaper.transition.step or 90);
  transitionDuration = toString (opts.wallpaper.transition.duration or 1);
  transitionFps = toString (opts.wallpaper.transition.fps or 60);

  displayCount = builtins.length displays;
  displayListStr = lib.concatMapStringsSep "\n" (
    idx:
    let
      display = builtins.elemAt displays idx;
    in
    "${toString (idx + 1)}: ${display.output} - ${toString display.width}x${toString display.height} (${display.orientation})"
  ) (lib.range 0 (displayCount - 1));
  displayCaseStr = lib.concatMapStringsSep "\n" (
    idx:
    let
      display = builtins.elemAt displays idx;
    in
    "${toString (idx + 1)})\n DISPLAY_OUTPUT=\"${display.output}\"\n DISPLAY_ORIENTATION=\"${display.orientation}\"\n ;;"
  ) (lib.range 0 (displayCount - 1));
  singleDisplayOutput = if displayCount == 1 then (builtins.elemAt displays 0).output else "";
  singleDisplayOrientation =
    if displayCount == 1 then (builtins.elemAt displays 0).orientation else "";
in
pkgs.writeShellScriptBin "launcher" ''
    if pidof rofi >/dev/null; then
      pkill rofi
      exit 0
    fi

    case $1 in
    drun)
      rofi_theme="''${XDG_CONFIG_HOME:-$HOME/.config}/rofi/launchers/type-2/style-2.rasi"
      r_override="entry{placeholder:'Search Applications...';}listview{lines:9;}"
      rofi -show drun -theme-str "$r_override" -theme "$rofi_theme"
      ;;
    window)
      rofi_theme="''${XDG_CONFIG_HOME:-$HOME/.config}/rofi/launchers/type-4/style-4.rasi"
      r_override="entry{placeholder:'Search Windows...';}listview{lines:12;}"
      rofi -show window -theme-str "$r_override" -theme "$rofi_theme"
      ;;
    file)
      rofi_theme="''${XDG_CONFIG_HOME:-$HOME/.config}/rofi/launchers/type-2/style-2.rasi"
      r_override="entry{placeholder:'Search Files...';}listview{lines:8;}"
      rofi -show filebrowser -theme-str "$r_override" -theme "$rofi_theme"
      ;;
    tmux)
      rofi_theme="''${XDG_CONFIG_HOME:-$HOME/.config}/rofi/launchers/type-4/style-4.rasi"
      r_override="entry{placeholder:'Search Tmux Sessions...';}listview{lines:15;}"
      sessions=$(tmux ls -F '#{session_name}: #{session_path} (#{session_windows} windows)' |
        rofi -dmenu -i -theme-str "$r_override" -theme "$rofi_theme" | cut -d: -f1)
      if [[ $sessions ]]; then
        ${terminal} --hold -e tmux attach -t $sessions
      fi
      ;;
    rbw)
      rofi_theme="''${XDG_CONFIG_HOME:-$HOME/.config}/rofi/launchers/type-1/style-6.rasi"
      rofi-rbw --selector rofi --selector-args="-theme $rofi_theme"
      ;;
    wallpaper)
      WALLPAPER_DIR="${wallpaperDir}"
      LANDSCAPE_DIR="${landscapeDir}"
      PORTRAIT_DIR="${portraitDir}"
      DISPLAY_COUNT=${toString displayCount}

      if [ "$DISPLAY_COUNT" -eq 1 ]; then
        DISPLAY_OUTPUT="${singleDisplayOutput}"
        DISPLAY_ORIENTATION="${singleDisplayOrientation}"
      else
        rofi_theme_display="''${XDG_CONFIG_HOME:-$HOME/.config}/rofi/launchers/wallpaper/display-select.rasi"
        r_override_display="entry{placeholder:'Select Display...';}listview{lines:$DISPLAY_COUNT;}"
        DISPLAY_CHOICE=$(cat <<EOF | rofi -dmenu -i -theme-str "$r_override_display" -theme "$rofi_theme_display" -format 'i:s'
  ${displayListStr}
  EOF
        )
        [ -z "$DISPLAY_CHOICE" ] && exit 0
        TARGET_DISPLAY=$(echo "$DISPLAY_CHOICE" | cut -d':' -f2 | cut -d':' -f1 | tr -d ' ')
        case "$TARGET_DISPLAY" in
  ${displayCaseStr}
          *)
            echo "Invalid display selection"
            exit 1
            ;;
        esac
      fi

      CACHE_DIR="''${XDG_CACHE_HOME:-$HOME/.cache}/wallpaper-thumbnails"
      CACHE_FLAG="$CACHE_DIR/.cache_ready"

      if [ "$DISPLAY_ORIENTATION" = "landscape" ]; then
        rofi_theme="''${XDG_CONFIG_HOME:-$HOME/.config}/rofi/launchers/wallpaper/wallpaper-select-landscape.rasi"
        SEARCH_DIR="$LANDSCAPE_DIR"
        THUMB_SIZE="320x180"
      else
        rofi_theme="''${XDG_CONFIG_HOME:-$HOME/.config}/rofi/launchers/wallpaper/wallpaper-select-portrait.rasi"
        SEARCH_DIR="$PORTRAIT_DIR"
        THUMB_SIZE="180x320"
      fi

      r_override="entry{placeholder:'Search Wallpapers for $DISPLAY_OUTPUT ($DISPLAY_ORIENTATION)...';}"

      generate_thumbnail() {
        local wallpaper="$1"
        local thumb_size="$2"
        local relative_path="''${wallpaper#$WALLPAPER_DIR/}"
        local wallpaper_name="''${relative_path%.*}"
        local thumbnail="$CACHE_DIR/''${wallpaper_name}.jpg"
        mkdir -p "$(dirname "$thumbnail")"
        if [ ! -f "$thumbnail" ]; then
          ${lib.getExe pkgs.imagemagick} "$wallpaper[0]" \
            -strip -gravity center \
            -thumbnail "$thumb_size^" \
            -extent "$thumb_size" \
            "$thumbnail" 2>/dev/null || true
        fi
      }

      if [ ! -f "$CACHE_FLAG" ]; then
        mkdir -p "$CACHE_DIR"
        if command -v ${lib.getExe pkgs.parallel} >/dev/null 2>&1; then
          export WALLPAPER_DIR CACHE_DIR
          export -f generate_thumbnail
          ${lib.getExe pkgs.fd} --type f \
            -e jpg -e jpeg -e png -e webp -e jxl -e gif \
            . "$LANDSCAPE_DIR" \
            | ${lib.getExe pkgs.parallel} --will-cite -j4 \
              'generate_thumbnail {} "320x180"'
          ${lib.getExe pkgs.fd} --type f \
            -e jpg -e jpeg -e png -e webp -e jxl -e gif \
            . "$PORTRAIT_DIR" \
            | ${lib.getExe pkgs.parallel} --will-cite -j4 \
              'generate_thumbnail {} "180x320"'
        else
          ${lib.getExe pkgs.fd} --type f \
            -e jpg -e jpeg -e png -e webp -e jxl -e gif \
            . "$LANDSCAPE_DIR" | while read -r wallpaper; do
            generate_thumbnail "$wallpaper" "320x180"
          done
          ${lib.getExe pkgs.fd} --type f \
            -e jpg -e jpeg -e png -e webp -e jxl -e gif \
            . "$PORTRAIT_DIR" | while read -r wallpaper; do
            generate_thumbnail "$wallpaper" "180x320"
          done
        fi
        touch "$CACHE_FLAG"
      else
        ${lib.getExe pkgs.fd} --type f \
          -e jpg -e jpeg -e png -e webp -e jxl -e gif \
          . "$SEARCH_DIR" | while read -r wallpaper; do
          relative_path="''${wallpaper#$WALLPAPER_DIR/}"
          wallpaper_name="''${relative_path%.*}"
          thumbnail="$CACHE_DIR/''${wallpaper_name}.jpg"
          if [ ! -f "$thumbnail" ]; then
            generate_thumbnail "$wallpaper" "$THUMB_SIZE" &
          fi
        done
      fi

      CHOICE=$(${lib.getExe pkgs.fd} --type f \
        -e jpg -e jpeg -e png -e webp -e jxl -e gif \
        . "$SEARCH_DIR" \
        | sed "s|$WALLPAPER_DIR/||" \
        | while read -r A; do
            thumb_path="''${A%.*}.jpg"
            echo -en "$A\x00icon\x1f$CACHE_DIR/$thumb_path\n"
          done \
        | rofi -dmenu \
          -i \
          -theme-str "$r_override" \
          -theme "$rofi_theme")

      [ -z "$CHOICE" ] && exit 0

      WALLPAPER_PATH="$WALLPAPER_DIR/$CHOICE"

      swww img --outputs "$DISPLAY_OUTPUT" "$WALLPAPER_PATH" \
        --transition-type "${transitionType}" \
        --transition-step "${transitionStep}" \
        --transition-duration "${transitionDuration}" \
        --transition-fps "${transitionFps}"

      echo "Set wallpaper for Display $DISPLAY_OUTPUT ($DISPLAY_ORIENTATION): $WALLPAPER_PATH"
      ;;
    emoji)
      rofi_theme="''${XDG_CONFIG_HOME:-$HOME/.config}/rofi/launchers/type-4/style-4.rasi"
      r_override="entry{placeholder:'Search Emojis...';}listview{lines:15;}"
      rofi -modi emoji -show emoji -theme "''${rofi_theme}" -theme-str "$r_override"
      ;;
    games)
      r_override="entry{placeholder:'Search Games...';}listview{lines:15;}"
      rofi_theme="''${XDG_CONFIG_HOME:-$HOME/.config}/rofi/launchers/type-1/style-5.rasi"
      rofi -show games -modi games -theme "''${rofi_theme}" -theme-str "$r_override"
      ;;
    wallpaper-clear-cache)
      CACHE_DIR="''${XDG_CACHE_HOME:-$HOME/.cache}/wallpaper-thumbnails"
      if [ -d "$CACHE_DIR" ]; then
        rm -rf "$CACHE_DIR"
        echo "Wallpaper thumbnail cache cleared!"
      else
        echo "No cache to clear."
      fi
      ;;
    help | --help | -h)
      echo "Usage: launcher [ACTION]"
      echo "Launch various rofi modes with custom themes and settings."
      echo ""
      echo "Actions:"
      echo "  drun                   Launch application search mode"
      echo "  window                 Switch between open windows"
      echo "  file                   Browse and search files"
      echo "  tmux                   Search active tmux sessions"
      echo "  rbw                    Browse and search passwords"
      echo "  wallpaper              Select display and set wallpaper"
      echo "  wallpaper-clear-cache  Clear wallpaper thumbnail cache"
      echo "  emoji                  Search and insert emojis"
      echo "  games                  Launch games menu"
      echo "  help                   Display this help message"
      echo "  --help                 Same as 'help'"
      echo ""
      echo "If no action is specified, defaults to 'drun' mode."
      exit 0
      ;;
    *)
      exec "$0" drun
      ;;
    esac
''
