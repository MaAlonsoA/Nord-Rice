<h1 align="center">✨ BSPWM Desktop Setup Installer ✨</h1>

<p align="center">
  <img src="https://img.shields.io/github/last-commit/MaAlonsoA/Nord-Rice.git alt="Last Commit">
  
</p>

<p align="center">
  A clean, modern, nord themed and highly customizable BSPWM-based Linux desktop environment installer.
</p>

---

## 📜 Overview

This repository contains an installation script that sets up a complete BSPWM environment with essential tools, configurations, and fonts — ready to use after a single command.  
It also prepares **Zsh** with **Powerlevel10k** and installs the **zsh-sudo** plugin file to the path your `.zshrc` expects.

It installs and configures:

- **bspwm** — Tiling window manager
- **sxhkd** — Hotkey daemon
- **polybar** — Status bar
- **picom** — Compositor for transparency and effects
- **kitty** — GPU-based terminal emulator
- **rofi** — Application launcher
- **lsd** — Modern replacement for `ls`
- **feh** — Lightweight image viewer & wallpaper setter
- **git** — Needed to clone themes/plugins
- **bat** — (`batcat`) improved `cat`
- **imwheel** — Optional smoother mouse scrolling
- Custom **fonts**
- **Zsh** with Powerlevel10k and **zsh-sudo** plugin

---

## 📂 Configuration Structure

After installation, the following directories will be placed under `~/.config`:

```
bspwm/
sxhkd/
polybar/
picom/
kitty/
rofi/
lsd/
wallpaper/
```

Additional files:
- `.zshrc` and `p10k.zsh` in the user’s home directory.
- `p10k.zsh.root` for the root account.
- Fonts in `~/.local/share/fonts`.

---


## 🚀 Installation

1. **Clone this repository**
   ```bash
   git clone https://github.com/MaAlonsoA/Nord-Rice.git
   cd Nord-Rice
   ```

2. **Make the script executable**
   ```bash
   chmod +x install.sh
   ```

3. **Run the installer**
   ```bash
   ./install.sh
   ```

> If executed with `sudo`, the script will detect your non-root user and install configs accordingly.  
> The installer also clones **Powerlevel10k** into `~/powerlevel10k` and installs **zsh-sudo** to `/usr/share/zsh-sudo/sudo.plugin.zsh`.

---

## 🖥️ Default Keybindings

| Action                  | Keybinding             |
|-------------------------|------------------------|
| Launch terminal         | `Super + Return`       |
| Launch rofi (apps)      | `Super + D`            |
| Close window            | `Super + Q`            |
| Restart BSPWM           | `Super + Alt + R`      |
| Move focus (hjkl)       | `Super + H/J/K/L`      |
| Resize window           | `Super + Ctrl + H/J/K/L` |

*(You can customize all bindings in `~/.config/sxhkd/sxhkdrc`)*

---

## 🖼️ Post-Installation

- Log out of your session.
- In your login manager, select **BSPWM**.
- Log in and enjoy your setup!
- (Optional) If your mouse wheel scroll is too slow, add this line to `~/.config/bspwm/bspwmrc` **after** `picom &` and **before** Polybar:
  ```sh
  imwheel -b "4 5" > /dev/null 2>&1 &
  ```

Reload BSPWM without logout:
```bash
bspc wm -r
```

---

## 📸 Screenshots

<p align="center">
  <img src="docs/screenshot1.png" alt="BSPWM Screenshot" width="80%">
</p>

---


---
