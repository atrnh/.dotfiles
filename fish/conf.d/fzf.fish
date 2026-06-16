if command -q brew
    set -l fzf_bin (brew --prefix fzf 2>/dev/null)/bin
    if test -d "$fzf_bin"
        fish_add_path -g "$fzf_bin"
    end
end

set -gx FZF_DEFAULT_OPTS \
    '--color=bg+:#313244,bg:#1e1e2e,spinner:#f5e0dc,hl:#f38ba8' \
    '--color=fg:#cdd6f4,header:#585b70,info:#cba6f7,pointer:#fab387' \
    '--color=marker:#f5e0dc,fg+:#cdd6f4,prompt:#c0e7b6,hl+:#f38ba8' \
    "--preview 'bat --style=plain --tabs=2 --color=always --theme=Catppuccin-mocha {}'" \
    "--pointer='> '" \
    "--marker=' '" \
    "--prompt=' '" \
    --ansi

set -gx FZF_CTRL_T_OPTS \
    "--header 'CTRL-/ to toggle preview.'" \
    "--bind 'ctrl-/:toggle-preview'" \
    '--height=100%' \
    "--prompt='󰥨 '"

set -gx FZF_CTRL_R_OPTS \
    "--with-nth 3.. --bind 'alt-t:change-with-nth(1,3..|2..|3..)'" \
    '--preview-window hidden' \
    '--height=60%' \
    --reverse \
    "--prompt='󱎸 '"

set -gx FZF_ALT_C_OPTS \
    "--preview 'tree --level 3 {}'" \
    "--prompt=' cd '"

if command -q fd
    set -gx FZF_CTRL_T_COMMAND 'fd --hidden --follow --exclude .git .'
    set -gx FZF_ALT_C_COMMAND 'fd --type d --hidden --follow --exclude .git .'
end

fzf --fish | source
