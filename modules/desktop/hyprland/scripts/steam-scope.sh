#!/usr/bin/env bash
read -r WIDTH HEIGHT <<<$(hyprctl monitors -j | jq -r '  .[] | select(.focused == true) | "\(.width) \(.height)"')

gamescope -W "$WIDTH" -H "$HEIGHT" --steam --expose-wayland --backend sdl -- steam -tenfoot -pipewire-dmabuf
