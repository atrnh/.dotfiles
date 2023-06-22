  export FZF_DEFAULT_OPTS=" \
    --color=bg+:#313244,bg:#1e1e2e,spinner:#f5e0dc,hl:#f38ba8 \
    --color=fg:#cdd6f4,header:#f38ba8,info:#cba6f7,pointer:#f5e0dc \
    --color=marker:#f5e0dc,fg+:#cdd6f4,prompt:#c0e7b6,hl+:#f38ba8 \
    --header 'CTRL-/ to toggle preview.' \
    --pointer='' \
    --marker='' \
    --prompt='  ' \
    --bind 'ctrl-/:toggle-preview'"

  export FZF_CTRL_T_OPTS="
    --preview 'bat --style=plain --tabs=2 --color=always --theme=Catppuccin-mocha {}' \
    --height=100% \
    --prompt=' '"

  export FZF_CTRL_R_OPTS="
    --preview 'echo {}' \
    --preview-window hidden \
    --height=60% \
    --reverse \
    --prompt=' '"