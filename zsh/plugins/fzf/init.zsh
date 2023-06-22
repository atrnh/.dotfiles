fzf_init() {
  local brew_prefix=$(brew --prefix)
  # Setup fzf
  if [[ ! "$PATH" == *$brew_prefix/opt/fzf/bin* ]]; then
    PATH="${PATH:+${PATH}:}$brew_prefix/opt/fzf/bin"
  fi
  # Auto-completion
  [[ $- == *i* ]] && source "$brew_prefix/opt/fzf/shell/completion.zsh" 2> /dev/null
  # Key bindings
  source "$brew_prefix/opt/fzf/shell/key-bindings.zsh"

  source $LOCAL_BUNDLES/fzf/aliases.zsh
  source $LOCAL_BUNDLES/fzf/opts.zsh
}

if [ "$(command -v fzf)" ]; then
  fzf_init

  if [ "$(command -v fd)" ]; then
    _fzf_compgen_path() {
      fd --hidden --follow --exclude ".git" . "$1"
    }

    _fzf_compgen_dir() {
      fd --type d --hidden --follow --exclude ".git" . "$1"
    }
  fi

  _fzf_comprun() {
    local command=$1
    shift

    case "$command" in
      cd) fzf --height=80% --preview 'tree -C -L 3 {} | head -100' "$@" ;;
      vim) fzf --preview 'bat style=plain --tabs=2 --color=always --theme=Catppuccin-mocha {}' \
        --info=inline \
        --height=100% \
        --prompt=' ' \
        "$@" ;;
      *) fzf --preview 'bat -n --color=always {}' "$@" ;;
    esac
  }
fi
