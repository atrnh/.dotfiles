# source $(brew --prefix)/opt/antidote/share/antidote/antidote.zsh
# antidote load

source <(fzf --zsh)
bindkey '^R' fzf-history-widget
bindkey -M vicmd '^R' fzf-history-widget
bindkey -M viins '^R' fzf-history-widget

export PATH="/Users/ashley/.local/bin:$PATH"
