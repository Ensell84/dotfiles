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

linkit "$HOME/dotfiles/default.conf" "/etc/keyd/default.conf"
linkit "$HOME/dotfiles/.zshrc" "$HOME/.zshrc"
linkit "$HOME/dotfiles/nvim" "$HOME/.config/nvim"
linkit "$HOME/dotfiles/kitty" "$HOME/.config/kitty"
linkit "$HOME/dotfiles/.tmux.conf" "$HOME/.tmux.conf"

log "All tasks completed."
