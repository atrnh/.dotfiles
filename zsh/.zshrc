# Auto-update autocomplete cache once per day
autoload -Uz compinit
for dump in ~/.zcompdump(N.mh+24); do
  compinit
done
compinit -C

# Starship
eval "$(starship init zsh)"

# Antidote
source $(brew --prefix)/opt/antidote/share/antidote/antidote.zsh
antidote load

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
