# Dotfiles

Personal dotfiles managed with `stow`.

<img width="2880" height="1748" alt="Screenshot 2026-06-21 at 08-32-54" src="https://github.com/user-attachments/assets/350c7d87-70c6-42a9-a2cd-ecdbccf14200" />



\
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
<td>
    <img width="2880" height="1748" alt="Screenshot 2026-06-21 at 08-30-40" src="https://github.com/user-attachments/assets/6376ecd5-6e31-41ce-acdf-5fb281a32f35" />


  
</td>
<td>

<img width="2880" height="1748" alt="Screenshot 2026-06-21 at 08-30-54" src="https://github.com/user-attachments/assets/db3c97e1-90c4-4689-b257-8b26d72dd6b4" />

</td>
</tr>
<tr>
<td>
<img width="2880" height="1748" alt="Screenshot 2026-06-21 at 08-11-03" src="https://github.com/user-attachments/assets/4051284f-5a5f-41ac-a2ed-5ead9e29422b" />

  
</td>
<td>

<img width="2880" height="1748" alt="Screenshot 2026-06-21 at 08-08-50" src="https://github.com/user-attachments/assets/1bd2da48-99ba-415f-8fdb-e937d21c8be7" />

</td>
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

Custom TUI for Docker, themed to match the GitHub Dark Dimmed palette.

### Lazygit

Config: [`config.yml`](lazygit/Library/Application%20Support/lazygit/config.yml)

Custom TUI for git, themed to match the GitHub Dark Dimmed palette.

### Neovim

See [`nvim/.config/nvim/README.md`](nvim/.config/nvim/README.md) for the full plugin list, keybindings, and feature breakdown.

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

### tmux

Configs: [`.tmux.conf`](tmux/.tmux.conf), [`session-picker.sh`](tmux/scripts/session-picker.sh)

Terminal multiplexer.

- Vi-style pane navigation (`hjkl`) and arrow-key resizing
- `prefix + s` opens a popup custom session picker
- Clipboard integration via `xclip` in copy-mode

### Zed

Configs: [`keymap.json`](zed/.config/zed/keymap.json), [`settings.json`](zed/.config/zed/settings.json)

Zed editor keybindings and settings.
