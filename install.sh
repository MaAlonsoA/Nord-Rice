#!/usr/bin/env bash
set -euo pipefail


TARGET_USER="${SUDO_USER:-$USER}"
TARGET_HOME="$(getent passwd "$TARGET_USER" | cut -d: -f6)"
CONFIG_DIR="$TARGET_HOME/.config"

echo "[*] Installing for user: $TARGET_USER ($TARGET_HOME)"

echo "[*] Installing required packages from APT..."
sudo apt update && sudo apt install -y \
  bspwm \
  sxhkd \
  polybar \
  picom \
  kitty \
  rofi \
  lsd \
  feh \
  git \
  bat \
  imwheel

mkdir -p "$CONFIG_DIR"


echo "[*] Deploying configuration files..."
cp -r bspwm "$CONFIG_DIR/"
cp -r sxhkd "$CONFIG_DIR/"
cp -r polybar "$CONFIG_DIR/"
cp -r picom "$CONFIG_DIR/"
cp -r kitty "$CONFIG_DIR/"
cp -r rofi "$CONFIG_DIR/"
cp -r lsd "$CONFIG_DIR/"
cp -r wallpaper "$CONFIG_DIR/"


cp .zshrc "$TARGET_HOME/.zshrc"
cp p10k.zsh "$TARGET_HOME/.p10k.zsh"
sudo cp p10k.zsh.root /root/.p10k.zsh

if [[ ! -d "$TARGET_HOME/powerlevel10k" ]]; then
  echo "[*] Cloning Powerlevel10k into $TARGET_HOME/powerlevel10k ..."
  sudo -u "$TARGET_USER" git clone --depth=1 https://github.com/romkatv/powerlevel10k.git "$TARGET_HOME/.powerlevel10k"
fi

echo "[*] Installing zsh-sudo plugin into /usr/share/zsh-sudo ..."
TMP_DIR="$(mktemp -d)"
git clone --depth=1 https://github.com/ohmyzsh/ohmyzsh.git "$TMP_DIR/ohmyzsh"
sudo mkdir -p /usr/share/zsh-sudo
sudo cp "$TMP_DIR/ohmyzsh/plugins/sudo/sudo.plugin.zsh" /usr/share/zsh-sudo/sudo.plugin.zsh
rm -rf "$TMP_DIR"

if [[ ! -d "$TARGET_HOME/.fzf" ]]; then
  echo "[*] Installing fzf into $TARGET_HOME/.fzf ..."
  sudo -u "$TARGET_USER" git clone --depth=1 https://github.com/junegunn/fzf.git "$TARGET_HOME/.fzf"
fi

sudo -u "$TARGET_USER" "$TARGET_HOME/.fzf/install" --key-bindings --completion --no-update-rc

echo "[*] Installing fonts..."
mkdir -p "$TARGET_HOME/.local/share/fonts"
cp -r fonts/fonts/* "$TARGET_HOME/.local/share/fonts/"
fc-cache -f

echo "[*] Setting executable permissions for helper scripts..."
chmod +x "$CONFIG_DIR/polybar/launch.sh" 2>/dev/null || true
find "$CONFIG_DIR/polybar/scripts" -type f -maxdepth 1 -exec chmod +x {} \; 2>/dev/null || true
find "$CONFIG_DIR/bspwm/scripts" -type f -maxdepth 1 -exec chmod +x {} \; 2>/dev/null || true
chown -R "$TARGET_USER":"$TARGET_USER" \
  "$CONFIG_DIR" \
  "$TARGET_HOME/.zshrc" \
  "$TARGET_HOME/.p10k.zsh" \
  "$TARGET_HOME/.local/share/fonts" \
  "$TARGET_HOME/powerlevel10k"

echo "[✔] Installation completed successfully."
echo "Log out, select BSPWM as your session, and log back in."
