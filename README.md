<div align="center">

# macOS dotfiles

**My macOS development environment — a tiling-window setup built around yabai, skhd and SketchyBar, plus zsh, Neovim and a Homebrew bundle.**

![macOS](https://img.shields.io/badge/macOS-000000?logo=apple&logoColor=white)
![yabai](https://img.shields.io/badge/yabai-tiling%20WM-blue)
![SketchyBar](https://img.shields.io/badge/SketchyBar-status%20bar-orange)
![Neovim](https://img.shields.io/badge/Neovim-57A143?logo=neovim&logoColor=white)
![zsh](https://img.shields.io/badge/zsh-F15A24?logo=gnu-bash&logoColor=white)

</div>

## Overview

These are the configuration files behind my day-to-day macOS setup: a keyboard-driven tiling
window manager ([yabai](https://github.com/koekeishiya/yabai) + [skhd](https://github.com/koekeishiya/skhd)),
a custom status bar ([SketchyBar](https://github.com/FelixKratz/SketchyBar)), a configured shell
(zsh + Powerlevel10k), a [Neovim](https://neovim.io/) config, and a [Homebrew](https://brew.sh/)
`Brewfile` capturing the tools I install on a fresh machine.

The goal is a reproducible environment: clone the repo, run the bootstrap script, and get back a
familiar workspace with vim-style window navigation and a tidy menu bar.

## Highlights

- **Tiling window management** — yabai for layout, skhd for vim-style (`alt + h/j/k/l`) focus,
  warp and swap bindings, plus space management across four labelled spaces
  (communication / daily / coding / classbro).
- **Custom status bar** — a SketchyBar config (`items/`, `plugins/`) showing spaces, the front
  app, battery, Wi-Fi, volume, calendar and now-playing media, with a per-space app-icon plugin.
- **Configured shell** — zsh with Powerlevel10k, autosuggestions, syntax highlighting and fzf.
- **Neovim** — a `packer`-managed Lua config (`nvim/init.lua`).
- **Reproducible installs** — `Brewfile` for `brew bundle` and an `install.sh` bootstrap.

## What's inside

| Path          | What it configures                                                           |
| ------------- | ---------------------------------------------------------------------------- |
| `yabai/`      | Tiling window manager rules + `create_spaces.sh`                             |
| `skhd/skhdrc` | Hotkey daemon — window focus/move/swap, space switching                      |
| `sketchybar/` | Status bar: `items/`, `plugins/` (incl. `space.py`), `colors.sh`, `icons.sh` |
| `nvim/`       | Neovim Lua config (packer)                                                   |
| `zsh/`        | `.zshrc`, `.p10k.zsh` and alternative shell configs                          |
| `fzf/`        | fzf shell integration                                                        |
| `Brewfile`    | Homebrew packages, casks and taps                                            |
| `install.sh`  | macOS bootstrap (Homebrew, yabai, SketchyBar, dev tools)                     |

## Getting started

> **Platform:** macOS only (Apple Silicon or Intel). The tiling features depend on yabai.

```bash
git clone https://github.com/rNLKJA/dotfiles.git
cd dotfiles

# Install Homebrew, yabai, SketchyBar and core dev tools
./install.sh

# Or just restore the Homebrew packages
brew bundle --file=./Brewfile
```

Then symlink the individual configs into `~/.config` and `~` as you prefer (e.g. `zsh/.zshrc` →
`~/.zshrc`, `sketchybar/` → `~/.config/sketchybar`, `nvim/` → `~/.config/nvim`).

### A note on yabai and System Integrity Protection

Some yabai features (managing spaces, window shadows/transparency, animations, sticky windows,
picture-in-picture) require **System Integrity Protection (SIP)** to be partially disabled.

<details>
<summary>How to partially disable SIP for yabai</summary>

1. **Boot into Recovery Mode**
   - Intel Macs: hold <kbd>⌘</kbd> + <kbd>R</kbd> while booting.
   - Apple Silicon: hold the power button until "Loading startup options" appears, then choose
     **Options → Continue**.

2. **Disable SIP** (open Terminal from the Utilities menu). For Apple Silicon (macOS 13+):

   ```bash
   csrutil enable --without fs --without debug --without nvram
   ```

3. **Apple Silicon only** — after rebooting:

   ```bash
   sudo nvram boot-args=-arm64e_preview_abi
   ```

4. **Verify**:
   ```bash
   csrutil status
   ```

To **re-enable** SIP later: boot into Recovery Mode and run `csrutil enable`, then reboot.

> SIP is re-enabled automatically if your device is serviced at an Apple Store or Authorised
> Service Provider.

</details>

## Notes

- These configs are tuned to my own machine and key bindings — fork and adjust to taste.
- Generated shell caches (`.zcompdump`, `.zsh_sessions/`) are now git-ignored; older clones may
  still carry them.
