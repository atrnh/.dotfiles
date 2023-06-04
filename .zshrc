# Auto-update autocomplete cache once per day
autoload -Uz compinit
for dump in ~/.zcompdump(N.mh+24); do
  compinit
done
compinit -C

export PATH="$HOME/Library/Python/3.9/bin:/usr/local/bin:$HOME/.cargo/bin:/usr/local/opt/postgresql@10/bin:/usr/local/opt/openssl/bin:/opt/local/bin/:/opt/local/sbin:$HOME/bin:/usr/local/bin:/usr/local/texlive/2020basic/:/Applications/Visual\ Studio\ Code.app/Contents/Resources/app/bin:$PATH"
export MANPATH=/usr/local/man:/opt/local/share/man:$MANPATH

export SSH_KEY_PATH="~/.ssh/rsa_id"
if [[ -n $SSH_CONNECTION ]]; then
  export EDITOR='nvim'
else
  export EDITOR='nvim'
fi

export LANG=en_US.UTF-8

export ZSH="$HOME/.oh-my-zsh"
export DOTFILES_REPO="$HOME/.dotfiles"
export LOCAL_BUNDLES="$DOTFILES_REPO/zsh/plugins"

source /usr/local/share/antigen/antigen.zsh

antigen use oh-my-zsh
antigen bundle git
antigen bundle vi-mode
antigen bundle history-substring-search
antigen bundle "$LOCAL_BUNDLES/general"
antigen bundle "$LOCAL_BUNDLES/asdf"
antigen bundle "$LOCAL_BUNDLES/bat"
antigen bundle "$LOCAL_BUNDLES/brew"
antigen bundle "$LOCAL_BUNDLES/bun"
antigen bundle "$LOCAL_BUNDLES/fzf"
antigen bundle "$LOCAL_BUNDLES/yarn"
antigen bundle "$LOCAL_BUNDLES/starship"
antigen bundle "$LOCAL_BUNDLES/zoxide"
antigen bundle "$LOCAL_BUNDLES/poetry"
antigen bundle "$LOCAL_BUNDLES/ripgrep"
antigen bundle zsh-users/zsh-syntax-highlighting

antigen apply

source $DOTFILES_REPO/zsh/functions.sh
source $DOTFILES_REPO/zsh/aliases.sh
source $DOTFILES_REPO/zsh/secrets.sh

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

export PATH="$HOME/.yarn/bin:$HOME/.config/yarn/global/node_modules/.bin:$PATH"
