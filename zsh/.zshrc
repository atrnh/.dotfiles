# Auto-update autocomplete cache once per day
autoload -Uz compinit
for dump in ~/.zcompdump(N.mh+24); do
  compinit
done
compinit -C

# Starship
eval "$(starship init zsh)"

# Antigen
source $HOMEBREW_PREFIX/share/antigen/antigen.zsh

antigen use oh-my-zsh
antigen bundle git
antigen bundle vi-mode
antigen bundle history-substring-search
antigen bundle zsh-users/zsh-syntax-highlighting

for bun in $LOCAL_BUNDLES/*
do
  antigen bundle $bun 
done
antigen apply

ENABLE_CORRECTION="true"
COMPLETION_WAITING_DOTS="true"
DISABLE_UNTRACKED_FILES_DIRTY="true"

unsetopt correct_all
setopt correct

bindkey "^[[A" history-beginning-search-up
bindkey "^[[B" history-beginning-search-down
bindkey -M vicmd "k" history-beginning-search-up
bindkey -M vicmd "j" history-beginning-search-down
HISTORY_SUBSTRING_SEARCH_HIGHLIGHT_FOUND="bg=default,fg=green,bold"
HISTORY_SUBSTRING_SEARCH_HIGHLIGHT_NOT_FOUND="bg=default,fg=red,bold"
