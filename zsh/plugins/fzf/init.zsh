fzf_init() {
  local brew_prefix=$(brew --prefix)

  # Setup fzf
  # ---------
  if [[ ! "$PATH" == *$brew_prefix/opt/fzf/bin* ]]; then
    PATH="${PATH:+${PATH}:}$brew_prefix/opt/fzf/bin"
  fi

  # Auto-completion
  # ---------------
  [[ $- == *i* ]] && source "$brew_prefix/opt/fzf/shell/completion.zsh" 2> /dev/null

  # Key bindings
  # ------------
  source "$brew_prefix/opt/fzf/shell/key-bindings.zsh"

}

#
#
if [ "$(command -v fzf)" ]; then
  fzf_init

  # Catpuccin Mocha
  export FZF_DEFAULT_OPTS=" \
    --color=bg+:#313244,bg:#1e1e2e,spinner:#f5e0dc,hl:#f38ba8 \
    --color=fg:#cdd6f4,header:#f38ba8,info:#cba6f7,pointer:#f5e0dc \
    --color=marker:#f5e0dc,fg+:#cdd6f4,prompt:#c0e7b6,hl+:#f38ba8 \
    --header 'CTRL-/ to toggle preview.' \
    --bind 'ctrl-/:toggle-preview'"

  # export FZF_DEFAULT_OPTS="
  #   --color 'bg:#332f36,fg:#e6f3ff,fg+:#aaeed3,info:#6494ff,header:italic:#bbb8ff'
  #   --color 'pointer:#f27cc5,border:#9884b1,spinner:#cba0ff,marker:#f2cce3'
  #   --color 'prompt:#c8ffc3'
  #   --header 'CTRL-/ to toggle preview.'
  #   --bind 'ctrl-/:toggle-preview'"

  export FZF_CTRL_T_OPTS="
    --preview 'bat --style=plain --tabs=2 --color=always --theme=Catppuccin-mocha {}' \
    --height=100% \
    --prompt=' '"

  export FZF_CTRL_R_OPTS="
    --preview 'echo {}' \
    --preview-window up:3:wrap \
    --height=60% \
    --prompt=' '"

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
