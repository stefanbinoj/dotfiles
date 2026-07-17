#!/usr/bin/env zsh

set -eu

project_dir="$PWD"
session_name="${project_dir:t}"

# Replace spaces, dots, and colons with underscores.
session_name="${session_name//[ .:]/_}"

tmux new-session \
    -s "$session_name" \
    -n split \
    -c "$project_dir" \
    zsh \
    \; split-window \
        -h \
        -t "${session_name}:split" \
        -c "$project_dir" \
        zsh \
    \; new-window \
        -t "${session_name}:" \
        -n nvim \
        -c "$project_dir" \
        "exec nvim ." \
    \; new-window \
        -t "${session_name}:" \
        -n pi \
        -c "$project_dir" \
        "exec pi" \
    \; select-window \
        -t "${session_name}:nvim"

