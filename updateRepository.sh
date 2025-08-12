#!/usr/bin/env bash
# Exit on error, unset vars, and fail pipelines if any segment fails
set -euo pipefail

# Source home (first arg or $HOME) and repo dir (this script's directory)
SRC_HOME="${1:-$HOME}"
REPO_DIR="$(cd "$(dirname "$0")" && pwd)"

echo "[*] Exporting configs from: $SRC_HOME -> $REPO_DIR"

# Copy selected .config subdirs into the repo
for d in bspwm kitty lsd picom polybar rofi sxhkd ; do
  if [[ -d "$SRC_HOME/.config/$d" ]]; then
    cp -r "$SRC_HOME/.config/$d" "$REPO_DIR/"
    echo "  - Copied: $SRC_HOME/.config/$d"
  fi
done

# Copy shell configs
if [[ -f "$SRC_HOME/.zshrc" ]]; then
  cp "$SRC_HOME/.zshrc" "$REPO_DIR/.zshrc"
  echo "  - Copied: $SRC_HOME/.zshrc"
fi

if [[ -f "$SRC_HOME/.p10k.zsh" ]]; then
  cp "$SRC_HOME/.p10k.zsh" "$REPO_DIR/p10k.zsh"
  echo "  - Copied: $SRC_HOME/.p10k.zsh -> p10k.zsh"
fi

# Root prompt (optional; requires sudo)
if [[ -f "/root/.p10k.zsh" ]]; then
  if sudo -n true 2>/dev/null; then
    sudo cp "/root/.p10k.zsh" "$REPO_DIR/p10k.zsh.root"
    echo "  - Copied: /root/.p10k.zsh -> p10k.zsh.root"
  else
    echo "  - Skipped: /root/.p10k.zsh (sudo needed)"
  fi
fi

echo "[✔] Repo updated with local configs."
