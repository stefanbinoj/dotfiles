DISABLE_UNTRACKED_FILES_DIRTY="true"
HIST_STAMPS="dd/mm/yyyy"
KEYTIMEOUT=1

# zinit
source "$HOME/.local/share/zinit/zinit.git/zinit.zsh"
zinit light jeffreytse/zsh-vi-mode
zinit wait lucid for \
    zsh-users/zsh-autosuggestions \
    zsh-users/zsh-syntax-highlighting
zinit snippet https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/themes/robbyrussell.zsh-theme
bindkey '^ ' autosuggest-accept

# tab completion
autoload -Uz compinit
compinit -C

# nvm
eval "$(fnm env --use-on-cd)"

# zoxide
eval "$(zoxide init zsh)"

# orbstack
source ~/.orbstack/shell/init.zsh 2>/dev/null || :

# pyenv
eval "$(pyenv init --path)"
eval "$(pyenv init -)"

# direnv
eval "$(direnv hook zsh)"

# Aliases
alias zed="open -a /Applications/Zed.app -n"
alias vi=nvim
alias lg=lazygit
alias ld=lazydocker
alias cat=bat
