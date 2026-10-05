<div align="center">

# macOS dotfiles

**My macOS development environment — a SketchyBar status bar, zsh, Neovim and a Homebrew bundle.**

![macOS](https://img.shields.io/badge/macOS-000000?logo=apple&logoColor=white)
![SketchyBar](https://img.shields.io/badge/SketchyBar-status%20bar-orange)
![Neovim](https://img.shields.io/badge/Neovim-57A143?logo=neovim&logoColor=white)
![zsh](https://img.shields.io/badge/zsh-F15A24?logo=gnu-bash&logoColor=white)

</div>

## Overview

These are the configuration files behind my day-to-day macOS setup: a custom status bar ([SketchyBar](https://github.com/FelixKratz/SketchyBar)), a configured shell
(zsh + Powerlevel10k), a [Neovim](https://neovim.io/) config, and a [Homebrew](https://brew.sh/)
`Brewfile` capturing the tools I install on a fresh machine.

The goal is a reproducible environment: clone the repo, run the bootstrap script, and get back a
familiar workspace with a tidy menu bar.

## Highlights

- **Custom status bar** — a SketchyBar config (`items/`, `plugins/`) showing spaces, the front
  app, battery, Wi-Fi, volume, calendar and now-playing media, with a per-space app-icon plugin.
- **Configured shell** — zsh with Powerlevel10k, autosuggestions, syntax highlighting and fzf.
- **Neovim** — a `packer`-managed Lua config (`nvim/init.lua`).
- **Reproducible installs** — `Brewfile` for `brew bundle` and an `install.sh` bootstrap.

## What's inside

| Path          | What it configures                                                           |
| ------------- | ---------------------------------------------------------------------------- |
| `sketchybar/` | Status bar: `items/`, `plugins/` (incl. `space.py`), `colors.sh`, `icons.sh` |
| `nvim/`       | Neovim Lua config (packer)                                                   |
| `zsh/`        | `.zshrc`, `.p10k.zsh` and alternative shell configs                          |
| `fzf/`        | fzf shell integration                                                        |
| `Brewfile`    | Homebrew packages, casks and taps                                            |
| `install.sh`  | macOS bootstrap (Homebrew, SketchyBar, dev tools)                            |

## Getting started

> **Platform:** macOS only (Apple Silicon or Intel).

```bash
git clone https://github.com/rNLKJA/dotfiles.git
cd dotfiles

# Install Homebrew, SketchyBar and core dev tools
./install.sh

# Or just restore the Homebrew packages
brew bundle --file=./Brewfile
```

Then symlink the individual configs into `~/.config` and `~` as you prefer (e.g. `zsh/.zshrc` →
`~/.zshrc`, `sketchybar/` → `~/.config/sketchybar`, `nvim/` → `~/.config/nvim`).

## Notes

- These configs are tuned to my own machine and key bindings — fork and adjust to taste.
- yabai and skhd (tiling window manager and hotkey daemon) were removed in October 2026. The
  SketchyBar space plugins (`plugins/yabai.sh`, `plugins/space.py`) still expect yabai and
  need reworking if SketchyBar is used again.
- Generated shell caches (`.zcompdump`, `.zsh_sessions/`) are now git-ignored; older clones may
  still carry them.
