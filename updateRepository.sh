
set -euo pipefail


SRC_HOME="${1:-$HOME}"
REPO_DIR="$(cd "$(dirname "$0")" && pwd)"

echo "[*] Exporting configs from: $SRC_HOME -> $REPO_DIR"


for d in bspwm kitty polybar rofi sxhkd; do
  if [[ -d "$SRC_HOME/.config/$d" ]]; then
    cp -r "$SRC_HOME/.config/$d" "$REPO_DIR/"
    echo "  - Copied: $SRC_HOME/.config/$d"
  fi
done


if [[ -f "$SRC_HOME/.zshrc" ]]; then
  cp "$SRC_HOME/.zshrc" "$REPO_DIR/.zshrc"
  echo "  - Copied: $SRC_HOME/.zshrc"
fi
if [[ -f "$SRC_HOME/.p10k.zsh" ]]; then
  cp "$SRC_HOME/.p10k.zsh" "$REPO_DIR/p10k.zsh"
  echo "  - Copied: $SRC_HOME/.p10k.zsh -> p10k.zsh"
fi

# Prompt de root (requiere sudo si no tienes permisos)
if [[ -f "/root/.p10k.zsh" ]]; then
  sudo cp "/root/.p10k.zsh" "$REPO_DIR/p10k.zsh.root"
  echo "  - Copied: /root/.p10k.zsh -> p10k.zsh.root"
fi

echo "[✔] Repo updated with local configs."
