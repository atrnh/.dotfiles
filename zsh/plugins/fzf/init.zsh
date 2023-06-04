if [ "$(command -v fzf)" ]; then
  # init
  if [[ ! "$PATH" == */usr/local/opt/fzf/bin* ]]; then
    PATH="${PATH:+${PATH}:}/usr/local/opt/fzf/bin"
  fi

  # auto completions
  [[ $- == *i* ]] && source "/usr/local/opt/fzf/shell/completion.zsh" 2> /dev/null

  # key bindings
  source "/usr/local/opt/fzf/shell/key-bindings.zsh"

  # opts
  export FZF_DEFAULT_OPTS="
    --color 'bg:#332f36,fg:#e6f3ff,fg+:#aaeed3,info:#6494ff,header:italic:#bbb8ff'
    --color 'pointer:#f27cc5,border:#9884b1,spinner:#cba0ff,marker:#f2cce3'
    --color 'prompt:#c8ffc3'
    --header 'CTRL-/ to toggle preview.'
    --bind 'ctrl-/:toggle-preview'"

  export FZF_CTRL_T_OPTS="
    --preview 'bat -n --color=always --theme=ansi {}' --preview-window up:8:wrap
    --prompt='  '"

  export FZF_CTRL_R_OPTS="
    --preview 'echo {}' --preview-window up:2:hidden:wrap
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
      cd)           fzf --height=60% --preview 'tree -C -L 3 {} | head -100' --preview-window up:10   "$@" ;;
      # export|unset) fzf --preview "eval 'echo \$'{}"         "$@" ;;
      # ssh)          fzf --preview 'dig {}'                   "$@" ;;
      # *)            fzf --preview 'bat -n --color=always {}' "$@" ;;
    esac
  }
fi
