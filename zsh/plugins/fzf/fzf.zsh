# Setup fzf
# ---------
if [[ ! "$PATH" == */usr/local/opt/fzf/bin* ]]; then
  PATH="${PATH:+${PATH}:}/usr/local/opt/fzf/bin"
fi

# Auto-completion
# ---------------
[[ $- == *i* ]] && source "/usr/local/opt/fzf/shell/completion.zsh" 2> /dev/null

# Key bindings
# ------------
source "/usr/local/opt/fzf/shell/key-bindings.zsh"

export FZF_DEFAULT_OPTS=" \
  --color=bg+:#313244,bg:#1e1e2e,spinner:#f5e0dc,hl:#f38ba8 \
  --color=fg:#cdd6f4,header:#f38ba8,info:#cba6f7,pointer:#f5e0dc \
  --color=marker:#f5e0dc,fg+:#cdd6f4,prompt:#cba6f7,hl+:#f38ba8 \
  --header 'CTRL-/ to toggle preview.' \
  --bind 'ctrl-/:toggle-preview'"

export FZF_CTRL_T_OPTS=" \
  --preview 'bat -n --color=always --theme=ansi {}' --preview-window up:8:wrap \
  --prompt='  '"

export FZF_CTRL_R_OPTS=" \
  --preview 'echo {}' --preview-window up:2:hidden:wrap \
  --prompt='  '"

# export FZF_COMPLETION_OPTS=''

_fzf_compgen_path() {
  fd --hidden --follow --exclude ".git" . "$1"
}
_fzf_compgen_dir() {
  fd --type d --hidden --follow --exclude ".git" . "$1"
}
_fzf_comprun() {
  local command=$1
  shift

  case "$command" in
    cd) fzf --height=60% --preview 'tree -C -L 3 {} | head -100' --preview-window up:10 "$@" ;;
    # export|unset) fzf --preview "eval 'echo \$'{}"         "$@" ;;
    # ssh)          fzf --preview 'dig {}'                   "$@" ;;
    *) fzf --preview 'bat -n --color=always {}' "$@" ;;
  esac
}
