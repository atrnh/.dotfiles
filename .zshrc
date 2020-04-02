export PATH=$HOME/.cargo/bin:/usr/local/opt/postgresql@10/bin:/usr/local/opt/openssl/bin:/opt/local/bin/:/opt/local/sbin:$HOME/bin:/usr/local/bin:$HOME/Library/Python/3.7/bin:/usr/local/texlive/2019basic/bin/x86_64-darwin/:$PATH
export MANPATH=/usr/local/man:/opt/local/share/man:$MANPATH

export ZSH="$HOME/.oh-my-zsh"

ZSH_THEME="spaceship"
ENABLE_CORRECTION="true"
COMPLETION_WAITING_DOTS="true"
DISABLE_UNTRACKED_FILES_DIRTY="true"

plugins=(
  git
  vi-mode
  history-substring-search
)

# brew completions
if type brew&>/dev/null; then
  FPATH=$(brew --prefix)/share/zsh/site-functions:$FPATH
fi

source $ZSH/oh-my-zsh.sh

export LANG=en_US.UTF-8

if [[ -n $SSH_CONNECTION ]]; then
  export EDITOR='nvim'
else
  export EDITOR='nvim'
fi

# ssh
export SSH_KEY_PATH="~/.ssh/rsa_id"

# general
alias v="/usr/local/bin/nvim"
alias vi="/usr/local/bin/nvim"
alias vim="/usr/local/bin/nvim"
alias http="http -v"

# hackbright
alias fenv="source /Users/ashleytrinh/.local/share/virtualenvs/flask-env-sPrF8dR1/bin/activate"

# # nvm
# export NVM_DIR="$HOME/.nvm"
# [ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
# [ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion<Paste>

# fzf
[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

# pyvenv
# if command -v pyenv 1>/dev/null 2>&1; then
#   eval "$(pyenv init -)"
# fi

# Interactively search for errant process with peco and kill it
function ikill {
  local line=$(lsof -i -n -P | peco | tr -s ' ')
  local pid=$(echo $line | cut -d ' ' -f 2)
  local cmd=$(echo $line | cut -d ' ' -f 1)
  local name=$(echo $line | cut -d ' ' -f 9)

  kill -9 $pid && echo "Killed $cmd at $name"
}

# output advising notes as markdown, redir to clipboard
# takes in 1 arg which is tag name (student's name)
function hbadvise {
  jrnl "@$1" -from today --export markdown | python3 -m markdown | pbcopy
}

function slackqa {
  kitty @ new-window --title "presenter" --new-tab --tab-title "slackterm"
  kitty @ detach-tab -m title:slackterm
  kitty @ set-colors -m title:presenter ~/.dotfiles/lightkitty.conf
  kitty @ set-background-opacity -m title:presenter 0.6
}

SPACESHIP_PROMPT_ORDER=(
  time
  user
  dir
  host
  git
  package
  venv
  battery
  line_sep
  vi_mode
)
SPACESHIP_TIME_SHOW=true
SPACESHIP_TIME_AMPM_SHOW=true
SPACESHIP_TIME_PM=" "
SPACESHIP_TIME_AM="  "
SPACESHIP_TIME_PREFIX=" "
SPACESHIP_TIME_12HR=true
SPACESHIP_TIME_FORMAT="%D{%-I:%M \033[34mon\033[0m %-m/%d }"
SPACESHIP_DIR_PREFIX="\033[34min\033[0m "
SPACESHIP_VI_MODE_INSERT="  "
SPACESHIP_VI_MODE_NORMAL="  "
SPACESHIP_VI_MODE_SUFFIX=""
SPACESHIP_VI_MODE_COLOR="red"
SPACESHIP_GIT_STATUS_PREFIX=" "
SPACESHIP_GIT_STATUS_SUFFIX=" "
SPACESHIP_GIT_STATUS_UNTRACKED=""
SPACESHIP_GIT_STATUS_ADDED=" "
SPACESHIP_GIT_STATUS_MODIFIED=""
SPACESHIP_GIT_STATUS_RENAMED=" "
SPACESHIP_GIT_STATUS_DELETED=""
SPACESHIP_GIT_STATUS_STASHED=""
SPACESHIP_GIT_STATUS_UNMERGED=""
SPACESHIP_GIT_STATUS_AHEAD=""
SPACESHIP_GIT_STATUS_BEHIND=""
SPACESHIP_GIT_STATUS_DIVERGED=""
SPACESHIP_NODE_SYMBOL="⬢ "
SPACESHIP_RUBY_SYMBOL=" "
SPACESHIP_VENV_SYMBOL=" "
SPACESHIP_VENV_PREFIX=""
SPACESHIP_VENV_COLOR="red"

# fasd
eval "$(fasd --init auto)"

alias cat=bat
alias diff=colordiff
alias present="kitty @ set-font-size 16"
alias pv=pipenv
alias pvr="pipenv run"
alias la="ls -a"

bindkey "^[[A" history-beginning-serach-up
bindkey "^[[B" history-beginning-serach-down
bindkey -M vicmd "k" history-beginning-serach-up
bindkey -M vicmd "j" history-beginning-serach-down
HISTORY_SUBSTRING_SEARCH_HIGHLIGHT_FOUND="bg=default,fg=green,bold"
HISTORY_SUBSTRING_SEARCH_HIGHLIGHT_NOT_FOUND="bg=default,fg=red,bold"
