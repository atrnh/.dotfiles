# Auto-update autocomplete cache once per day
autoload -Uz compinit
for dump in ~/.zcompdump(N.mh+24); do
  compinit
done
compinit -C

# Starship
eval "$(starship init zsh)"

# Antigen
source "$(brew --prefix)/share/antigen/antigen.zsh"

antigen use oh-my-zsh
antigen bundle git
antigen bundle vi-mode
antigen bundle zsh-users/zsh-history-substring-search
antigen bundle zsh-users/zsh-syntax-highlighting
antigen bundle jeffreytse/zsh-vi-mode

# Local bundles
for bundle in $LOCAL_BUNDLES/plugins/*; do
  antigen bundle $bundle --no-local-clone
done

antigen apply

ENABLE_CORRECTION="true"
COMPLETION_WAITING_DOTS="true"
DISABLE_UNTRACKED_FILES_DIRTY="true"

unsetopt correct_all
setopt correct

bindkey "^[[A" history-substring-search-up
bindkey "^[[B" history-substring-search-down
bindkey -M vicmd "k" history-substring-search-up
bindkey -M vicmd "j" history-substring-search-down
HISTORY_SUBSTRING_SEARCH_HIGHLIGHT_FOUND="bg=default,fg=green,bold"
HISTORY_SUBSTRING_SEARCH_HIGHLIGHT_NOT_FOUND="bg=default,fg=red,bold"
