# Dotfiles

<img width="1600" height="900" alt="Dotfiles Overview" src="https://placehold.co/1600x900/1e1e2e/ffffff?text=Dotfiles+Overview&font=roboto" />

Personal dotfiles managed with [GNU Stow](https://www.gnu.org/software/stow/). Each top-level directory is a stow package that mirrors its files into `$HOME`.

![stow](https://img.shields.io/badge/managed%20with-stow-8d1cdc?style=flat-square)
![platform](https://img.shields.io/badge/platform-macOS-blue?style=flat-square)

## Layout

```
dotfiles/
├── aerospace/   # Aerospace tiling WM
├── ghostty/     # Ghostty terminal
├── git/         # Global git config
├── karabiner/   # Karabiner-Elements
├── lazydocker/  # Lazydocker TUI
├── lazygit/     # Lazygit TUI
├── nvim/        # Neovim (see nvim/.config/nvim/README.md)
├── packages/    # Homebrew bundle
├── pi/          # pi coding agent
├── raycast/     # Raycast settings
├── shell/       # zsh + vimrc
├── ssh/         # SSH client config
├── tmux/        # tmux + session picker
└── zed/         # Zed editor
```

## Quick Start

```sh
brew install stow
git clone <repo> ~/dotfiles
cd ~/dotfiles
```

Apply individual packages:

```sh
stow --target=$HOME nvim
stow --target=$HOME tmux
stow --target=$HOME aerospace
```

Or stow everything at once:

```sh
stow --target=$HOME --dir=. */
```

Useful flags:

| Flag | Purpose |
| --- | --- |
| `--restow` | Re-link after editing tracked files |
| `--adopt` | Move conflicting existing files into the repo, then symlink |
| `--simulate` / `-n` | Dry run; show what would happen |
| `--delete` | Remove symlinks for a package |

## Screenshots

<table>
<tr>
<td><img alt="Aerospace" src="https://placehold.co/600x400/1e1e2e/ffffff?text=Aerospace&font=roboto" /></td>
<td><img alt="Ghostty" src="https://placehold.co/600x400/1e1e2e/ffffff?text=Ghostty&font=roboto" /></td>
</tr>
<tr>
<td><img alt="Neovim" src="https://placehold.co/600x400/1e1e2e/ffffff?text=Neovim&font=roboto" /></td>
<td><img alt="tmux" src="https://placehold.co/600x400/1e1e2e/ffffff?text=tmux&font=roboto" /></td>
</tr>
<tr>
<td><img alt="Lazygit" src="https://placehold.co/600x400/1e1e2e/ffffff?text=Lazygit&font=roboto" /></td>
<td><img alt="Lazydocker" src="https://placehold.co/600x400/1e1e2e/ffffff?text=Lazydocker&font=roboto" /></td>
</tr>
<tr>
<td><img alt="Shell" src="https://placehold.co/600x400/1e1e2e/ffffff?text=zsh&font=roboto" /></td>
<td><img alt="Zed" src="https://placehold.co/600x400/1e1e2e/ffffff?text=Zed&font=roboto" /></td>
</tr>
</table>

---

## Tools

### Aerospace — Tiling Window Manager

Config: [`aerospace.toml`](aerospace/.config/aerospace/aerospace.toml)

i3-style tiling window manager for macOS.

- Tiles windows across named workspaces
- Routes Ghostty to workspace 3 and Obsidian to workspace 9 on launch
- Floats System Preferences, Finder, and Preview

### Ghostty — Terminal

Config: [`config`](ghostty/.config/ghostty/config)

GPU-accelerated terminal emulator.

- GitHub Dark Dimmed theme, GeistMono NF font
- Wide-gamut (`display-p3`) colorspace
- Ligatures and cursor-jitter shell-integration disabled
- Reduced scroll multiplier for trackpad comfort

### Git

Config: [`config`](git/.config/git/config), [`work_config`](git/.config/git/work_config)

Global git configuration with a work-specific overlay.

- Base file holds shared aliases and tooling defaults
- `work_config` conditionally applies work identity, signing, and remotes

### Karabiner-Elements

Configs: [`karabiner.json`](karabiner/.config/karabiner/karabiner.json), [`karabiner-mac-mini.json`](karabiner/.config/karabiner/karabiner-mac-mini.json)

Complex key modifications on macOS.

- Caps Lock remapped to a hyper key (Ctrl+Opt+Cmd+Shift)
- Separate profile for the Mac Mini with a different keyboard layout

### Lazydocker

Config: [`config.yml`](lazydocker/Library/Application%20Support/lazydocker/config.yml)

Terminal UI for Docker.


### Lazygit

Config: [`config.yml`](lazygit/Library/Application%20Support/lazygit/config.yml)

Terminal UI for git.


### Neovim

See [`nvim/.config/nvim/README.md`](nvim/.config/nvim/README.md) for the full plugin list, keybindings, and feature breakdown.

### OpenCode

[`AGENTS.md`](opencode/.config/opencode/AGENTS.md) — Agent-level instructions shared with the OpenCode assistant.

### Packages — Homebrew Bundle

[`bundle`](packages/bundle) — `brew bundle` descriptor listing CLIs, casks, and Mac App Store apps.

```sh
brew bundle --file=packages/bundle
```

### pi — Coding Agent

Configs: [`settings.json`](pi/.pi/agent/settings.json), [`extensions/`](pi/.pi/agent/extensions), [`prompts/`](pi/.pi/agent/prompts)

Custom pi coding agent setup.

- Extensions: cost tracking, git status widget, Firecrawl search, tps tracker, update checker, whimsical, yeet
- Prompt templates for code simplification and handoff
- Custom GitHub Dark theme

### Raycast

[`raycast.rayconfig`](raycast/raycast.rayconfig) — Raycast preferences and extension configuration.

### Shell — zsh

Configs: [`.zshrc`](shell/.zshrc), [`.zprofile`](shell/.zprofile), [`.vimrc`](shell/.vimrc)

zsh shell setup.

- [zinit](https://github.com/zdharma-continuum/zinit) plugin manager
- zsh-vi-mode, autosuggestions, syntax highlighting, defer
- robbyrussell prompt with async rendering
- fnm for Node version management, zoxide for smart `cd`

### SSH

[`config`](ssh/.ssh/config) — Per-host client settings, keepalives, and jump hosts.

### tmux

Configs: [`.tmux.conf`](tmux/.tmux.conf), [`session-picker.sh`](tmux/scripts/session-picker.sh)

Terminal multiplexer.

- Vi-style pane navigation (`hjkl`) and arrow-key resizing
- `prefix + s` opens a popup custom session picker
- Clipboard integration via `xclip` in copy-mode

### Zed

Configs: [`keymap.json`](zed/.config/zed/keymap.json), [`settings.json`](zed/.config/zed/settings.json)

Zed editor keybindings and settings.
