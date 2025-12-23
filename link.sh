#!/bin/bash

log() {
  echo "[INFO] $1"
}

linkit() {
  SRC="$1"
  DEST="$2"
  if sudo ln -nfs "$SRC" "$DEST"; then
    log "Successfully linked $DEST"
  else
    log "Failed to link $DEST"
  fi
}

linkit "$HOME/dotfiles/configs/keyd/default.conf" "/etc/keyd/default.conf"
linkit "$HOME/dotfiles/configs/.bashrc" "$HOME/.bashrc"
linkit "$HOME/dotfiles/configs/nvim" "$HOME/.config/nvim"
linkit "$HOME/dotfiles/configs/tlp.conf" "/etc/tlp.conf"
linkit "$HOME/dotfiles/configs/foot" "$HOME/.config/foot"
linkit "$HOME/dotfiles/configs/fuzzel" "$HOME/.config/fuzzel"
linkit "$HOME/dotfiles/configs/hypr" "$HOME/.config/hypr"
linkit "$HOME/dotfiles/configs/waybar" "$HOME/.config/waybar"
linkit "$HOME/dotfiles/configs/mako" "$HOME/.config/mako"
#linkit "$HOME/dotfiles/configs/ghostty/config" "$HOME/.config/ghostty/config"
#linkit "$HOME/dotfiles/configs/niri" "$HOME/.config/niri"
#linkit "$HOME/dotfiles/configs/swaylock" "$HOME/.config/swaylock"
#linkit "$HOME/dotfiles/configs/.tmux.conf" "$HOME/.tmux.conf"

log "All tasks completed."
