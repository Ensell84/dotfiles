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

linkit "$HOME/dotfiles/configs/default.conf" "/etc/keyd/default.conf"
linkit "$HOME/dotfiles/configs/.bashrc" "$HOME/.bashrc"
linkit "$HOME/dotfiles/configs/nvim" "$HOME/.config/nvim"
linkit "$HOME/dotfiles/configs/.tmux.conf" "$HOME/.tmux.conf"
linkit "$HOME/dotfiles/configs/tlp.conf" "/etc/tlp.conf"
linkit "$HOME/dotfiles/configs/config" "$HOME/.config/ghostty/config"

log "All tasks completed."
