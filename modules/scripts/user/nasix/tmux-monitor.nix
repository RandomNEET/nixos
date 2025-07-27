{ pkgs, ... }:
pkgs.writeShellScriptBin "tmux-monitor" ''
  tmux new-session -d -s monitor -n cbonsai "sleep 0.2 && cbonsai -li -t 10 -L 64"
  tmux new-window -t monitor:2 -n gpu "watch -n 1 nvidia-smi"
  tmux select-window -t monitor:1
  tmux attach-session -t monitor
''
