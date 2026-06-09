set -gx LANG en_US.UTF-8
set -gx MANPATH /usr/local/man /opt/local/share/man $MANPATH

set -gx SSH_KEY_PATH "$HOME/.ssh/rsa_id"
if test -n "$SSH_CONNECTION"
    set -gx EDITOR vim
else
    set -gx EDITOR nvim
end

set -gx DOTFILES_REPO "$HOME/.dotfiles"
set -gx BAT_THEME Catppuccin-mocha
set -gx POETRY_CONFIG_DIR "$HOME/.config/pypoetry"
