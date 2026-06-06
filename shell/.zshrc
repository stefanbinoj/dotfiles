ZSH_THEME="robbyrussell"
DISABLE_AUTO_TITLE="true"
DISABLE_MAGIC_FUNCTIONS="true"
COMPLETION_WAITING_DOTS="true"
DISABLE_UNTRACKED_FILES_DIRTY="true"
HIST_STAMPS="dd/mm/yyyy"
plugins=(git zsh-autosuggestions)
bindkey '^ ' autosuggest-accept

source "$HOME/.oh-my-zsh/oh-my-zsh.sh"

# nvm
source "$(brew --prefix nvm)/nvm.sh"

# Aliases
alias zed="open -a /Applications/Zed.app -n"
alias vi=nvim
alias lg=lazygit
alias ld=lazydocker

# zoxide
eval "$(zoxide init zsh)"

# orbstack
source ~/.orbstack/shell/init.zsh 2>/dev/null || :

# pyenv
eval "$(pyenv init --path)"
eval "$(pyenv init -)"

# direnv
eval "$(direnv hook zsh)"
