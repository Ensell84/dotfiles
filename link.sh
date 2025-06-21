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

linkit "./default.conf" "/etc/keyd/default.conf"
linkit "./.bashrc" "$HOME/.bashrc"
linkit "./nvim" "$HOME/.config/nvim"
linkit "./.tmux.conf" "$HOME/.tmux.conf"
linkit "./tlp.conf" "/etc/tlp.conf"

mkdir $HOME/.config/foot
linkit "$HOME/dotfiles/foot.ini" "$HOME/.config/foot/foot.ini"

log "All tasks completed."
