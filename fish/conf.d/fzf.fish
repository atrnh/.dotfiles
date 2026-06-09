if command -q brew
    set -l fzf_bin (brew --prefix fzf 2>/dev/null)/bin
    if test -d "$fzf_bin"
        fish_add_path -g "$fzf_bin"
    end
end

if command -q fzf
    set -gx FZF_DEFAULT_OPTS \
        '--color=bg+:#313244,bg:#1e1e2e,spinner:#f5e0dc,hl:#f38ba8' \
        '--color=fg:#cdd6f4,header:#f38ba8,info:#cba6f7,pointer:#f5e0dc' \
        '--color=marker:#f5e0dc,fg+:#cdd6f4,prompt:#c0e7b6,hl+:#f38ba8' \
        "--header 'CTRL-/ to toggle preview.'" \
        '--pointer=> ' \
        '--marker=> ' \
        '--prompt=Search: ' \
        --ansi \
        "--bind 'ctrl-/:toggle-preview'"

    set -gx FZF_CTRL_T_OPTS \
        "--preview 'bat --style=plain --tabs=2 --color=always --theme=Catppuccin-mocha {}'" \
        '--height=100%' \
        '--prompt=Files: '

    set -gx FZF_CTRL_R_OPTS \
        "--preview 'echo {}'" \
        '--preview-window hidden' \
        '--height=60%' \
        --reverse \
        '--prompt=History: '

    if command -q fd
        set -gx FZF_CTRL_T_COMMAND 'fd --hidden --follow --exclude .git .'
        set -gx FZF_ALT_C_COMMAND 'fd --type d --hidden --follow --exclude .git .'
    end

    fzf --fish | source
end
