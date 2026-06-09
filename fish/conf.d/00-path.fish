for dir in \
    /opt/homebrew/bin \
    /opt/homebrew/sbin \
    /opt/local/bin \
    /opt/local/sbin \
    "$HOME/.local/bin" \
    "$HOME/.yarn/bin" \
    "$HOME/.config/yarn/global/node_modules/.bin"
    if test -d "$dir"
        fish_add_path -g "$dir"
    end
end
