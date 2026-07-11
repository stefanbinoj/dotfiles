#!/usr/bin/env bash
set -euo pipefail

ROOT="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
DOTFILES_DIR="${DOTFILES_DIR:-$ROOT}"
REPO_URL="https://github.com/stefanbinoj/dotfiles.git"

if ! command -v sudo >/dev/null 2>&1 || ! sudo -v; then
  cat <<MSG
This user cannot run sudo.

Ask an admin to run:
  su -
  usermod -aG sudo $USER

Then log out and log back in.
MSG
  exit 1
fi

sudo apt update
sudo apt install -y vim tmux curl git

if [ ! -f "$DOTFILES_DIR/shell/.vimrc" ]; then
  DOTFILES_DIR="$HOME/dotfiles"

  if [ ! -d "$DOTFILES_DIR/.git" ]; then
    if [ -e "$DOTFILES_DIR" ]; then
      echo "$DOTFILES_DIR exists but is not a git repo. Move it or set DOTFILES_DIR=/path/to/dotfiles."
      exit 1
    fi

    git clone "$REPO_URL" "$DOTFILES_DIR"
  fi
fi

if [ ! -f "$DOTFILES_DIR/shell/.vimrc" ]; then
  echo "Could not find shell/.vimrc in $DOTFILES_DIR"
  exit 1
fi

mkdir -p "$HOME/.vim/autoload" "$HOME/.vim/plugged" "$HOME/.vim/undodir"
curl -fLo "$HOME/.vim/autoload/plug.vim" \
  https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim

cp "$DOTFILES_DIR/shell/.vimrc" "$HOME/.vimrc"

cat > "$HOME/.tmux.conf" <<'TMUX'
set -g default-terminal "screen-256color"
set -s escape-time 0
set -g base-index 1
set -g pane-base-index 1
set -g renumber-windows on
set -g mouse on

set-window-option -g mode-keys vi
bind Space copy-mode
bind -T copy-mode-vi v send-keys -X begin-selection
bind -T copy-mode-vi y send-keys -X copy-selection-and-cancel

bind -r h select-pane -L
bind -r j select-pane -D
bind -r k select-pane -U
bind -r l select-pane -R

unbind C-b
set-option -g prefix C-s

bind [ split-window -h -c "#{pane_current_path}"
bind ] split-window -v -c "#{pane_current_path}"
TMUX

cat <<MSG
Done.

Next:
  1. Open vim
  2. Run :PlugInstall
  3. For LSP servers, open a C/C++ or Python file and run :LspInstallServer if needed
MSG
