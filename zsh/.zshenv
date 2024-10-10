export LANG=en_US.UTF-8
export MANPATH="/usr/local/man:/opt/local/share/man:$MANPATH"
export ZDOTDIR="$HOME/.config/zsh"

export SSH_KEY_PATH="$HOME/.ssh/rsa_id"
if [[ -n $SSH_CONNECTION ]]; then
  export EDITOR=vim
else
  export EDITOR=nvim
fi

export DOTFILES_REPO="$HOME/.dotfiles"

export STARSHIP_CONFIG="$HOME/.config/starship/starship.toml"
export BAT_THEME="Catppuccin-mocha"

export ENABLE_CORRECTION="true"
export COMPLETION_WAITING_DOTS="true"
export DISABLE_UNTRACKED_FILES_DIRTY="true"

# MacPorts Installer addition on 2024-03-26_at_17:10:29: adding an appropriate PATH variable for use with MacPorts.
export PATH="/opt/local/bin:/opt/local/sbin:$PATH"
# Finished adapting your PATH environment variable for use with MacPorts.

source <(/opt/homebrew/bin/brew shellenv)