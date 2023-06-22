if [ "$(command -v exa)" ]; then
  unalias -m ll
  unalias -m l
  unalias -m la
  unalias -m ls
  alias ls="exa -G --color auto --icons -a -s type"
  alias la="exa -G --color auto --icons -a -s type"
  alias l="exa -G--color auto --icons -a -s type"
  alias ll="exa -l --color always --icons -a -s type"
fi

# tree replacement
tree() {
  if [ "$(command -v exa)" ]; then exa --tree $@
  else command tree $@
  fi
}

# git status
gs() {
  if [ "$(command -v exa)" ]; then exa --long --git $@
  else git status $@
  fi
}