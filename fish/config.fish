set -g fish_greeting

if status is-interactive
    fish_vi_key_bindings

    set -g fish_cursor_default block
    set -g fish_cursor_insert line
    set -g fish_cursor_replace_one underscore
    set -g fish_cursor_visual block

    if functions -q fzf_key_bindings
        fzf_key_bindings
    end
end
