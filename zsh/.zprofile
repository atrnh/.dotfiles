eval "$(/opt/homebrew/bin/brew shellenv)"

# Config vars
export ZSH="$HOME/.oh-my-zsh"
export DOTFILES_REPO="$HOME/.dotfiles"
export LOCAL_BUNDLES="$DOTFILES_REPO/zsh"

export MANPATH=/usr/local/man:/opt/local/share/man:$MANPATH

export SSH_KEY_PATH="$HOME/.ssh/rsa_id"
# if [[ -n $SSH_CONNECTION ]]; then
#   export EDITOR='nvim'
# else
#   export EDITOR='nvim'
# fi
export EDITOR=nvim

export LANG=en_US.UTF-8

export STARSHIP_CONFIG="$HOME/.config/starship/starship.toml"

export BAT_THEME="Catppuccin-mocha"

##
# Your previous /Users/ashley/.zprofile file was backed up as /Users/ashley/.zprofile.macports-saved_2024-03-26_at_17:10:29
##

# MacPorts Installer addition on 2024-03-26_at_17:10:29: adding an appropriate PATH variable for use with MacPorts.
export PATH="/opt/local/bin:/opt/local/sbin:$PATH"
# Finished adapting your PATH environment variable for use with MacPorts.

