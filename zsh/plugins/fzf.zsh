local brew_prefix=$(brew --prefix)
# Setup fzf
if [[ ! "$PATH" == *$brew_prefix/opt/fzf/bin* ]]; then
  PATH="${PATH:+${PATH}:}$brew_prefix/opt/fzf/bin"
fi

source <(fzf --zsh)

if [ "$(command -v fzf)" ]; then
  export FZF_DEFAULT_OPTS=" \
    --color=bg+:#313244,bg:#1e1e2e,spinner:#f5e0dc,hl:#f38ba8 \
    --color=fg:#cdd6f4,header:#f38ba8,info:#cba6f7,pointer:#f5e0dc \
    --color=marker:#f5e0dc,fg+:#cdd6f4,prompt:#c0e7b6,hl+:#f38ba8 \
    --header 'CTRL-/ to toggle preview.' \
    --pointer='' \
    --marker='' \
    --prompt='  ' \
    --ansi \
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

  # Interactively search for errant process with peco and kill it
  ikill() {
    local line=$(lsof -i -n -P | fzf --reverse --pointer='' --prompt='Kill a process  ' --header='' --header-lines=1 | tr -s ' ')
    local pid=$(echo $line | cut -d ' ' -f 2)
    local cmd=$(echo $line | cut -d ' ' -f 1)
    local name=$(echo $line | cut -d ' ' -f 9)

    kill -9 $pid && echo "Killed $cmd at $name"
  }

  # Search for branch and checkout
  igco() {
    git checkout $(git branch --all | fzf --reverse --prompt='git checkout  ' --header='Search for a branch')
  }

  if [ "$(command -v fd)" ]; then
    _fzf_compgen_path() {
      fd --hidden --follow --exclude ".git" . "$1"
    }

    _fzf_compgen_dir() {
      fd --type d \
        --hidden \
        --follow \
        --exclude ".git" \
        --search-path="$1" \
        "."
    }
  fi

  if [ "$(command -v rg)" ]; then
    fzrg() {
      local rg_prefix="rg --no-heading --color=always --smart-case "
      fzf --disabled --query "${*:-}" \
        --bind "start:reload:$rg_prefix {q}" \
        --bind "change:reload:sleep 0.1; $rg_prefix {q} || true" \
        --delimiter : \
        --bind "enter:become(echo {1})" \
        --layout=reverse
    }
  fi

  _gh_issue_list() {
    gh issue list --json number,title,updatedAt --template \
      '{{tablerow "NUM" "TITLE" "UPDATED"}}{{range .}}{{tablerow .number .title (timeago .updatedAt)}}{{end}}{{tablerender}}'
  }

  ghid() {
    local issue_num=$(gh issue list --json number,title,updatedAt --template \
      '{{tablerow "NUM" "TITLE" "UPDATED"}}{{range .}}{{tablerow .number .title (timeago .updatedAt)}}{{end}}{{tablerender}}' \
       | fzf --reverse --prompt='gh issue develop  ' --header='' --header-lines=1 --info=inline --height=40% \
       | tr -s ' ' \
       | cut -d ' ' -f 1)
    if [ -z "$issue_num" ]; then
      return
    fi
    gh issue develop $issue_num --checkout
  }

  _fzf_comprun() {
    local command=$1
    shift

    case "$command" in
      cd) fzf --height=80% --preview 'tree -C -L 3 {} | head -100' "$@" ;;
      vim) fzf --preview 'bat style=plain --tabs=2 --color=always --theme=Catppuccin-mocha {}' \
        --info=inline \
        --height=100% \
        --prompt=' ' \
        --bind 'enter:become(nvim {} < /dev/tty > /dev/tty)' \
        "$@" ;;
      gh)
        local gh_cmd=$1
        shift
        local gh_subcmd=$1
        shift
        case "$gh_cmd" in
          issue) fzf --preview-window hidden "$@" ;;
          *) fzf "$@" ;;
        esac ;;
      *) fzf --preview 'bat -n --color=always {}' "$@" ;;
    esac
  }

  _fzf_complete_gco() {
    _fzf_complete --reverse --prompt="git checkout  " \
      --preview-window hidden \
      --header="Search for a branch" \
      -- "$@" < <(

      # git branch --sort=-committerdate --sort=-HEAD --color=never \
      #   --format=$'%(HEAD)\t%(refname:short)\t%(committerdate:relative)'
        git branch --sort=-committerdate --sort=-HEAD --format=$'%(refname:short)'
      )
  }

  _fzf_complete_ghid() {
    _fzf_complete --reverse --header='' --header-lines=1 \
      -- "$@" < <(
          gh issue list --json number,title,updatedAt --template \
            '{{tablerow "NUM" "TITLE" "UPDATED"}}{{range .}}{{tablerow .number .title (timeago .updatedAt)}}{{end}}{{tablerender}}'
        )
  }
fi

