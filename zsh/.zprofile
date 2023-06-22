# Config vars
export ZSH="$HOME/.oh-my-zsh"
export DOTFILES_REPO="$HOME/.dotfiles"
export LOCAL_BUNDLES="$DOTFILES_REPO/zsh/plugins"

eval "$(/opt/homebrew/bin/brew shellenv)"

export MANPATH=/usr/local/man:/opt/local/share/man:$MANPATH

export SSH_KEY_PATH="~/.ssh/rsa_id"
if [[ -n $SSH_CONNECTION ]]; then
  export EDITOR='nvim'
else
  export EDITOR='nvim'
fi

export LANG=en_US.UTF-8
