if [ "$(command -v exa)" ]; then
  unalias ll
  unalias l
  unalias la
  unalias ls
  alias ls="exa -G --color auto --icons -a -s type"
  alias la="exa -G --color auto --icons -a -s type"
  alias l="exa -G --color auto --icons -a -s type"
  alias ll="exa -l --color always --icons -a -s type"
fi

# tree replacement
tree() {
  if [ "$(command -v exa)" ]; then exa --tree --color auto --icons $@
  else tree $@
  fi
}

# git status
gs() {
  if [ "$(command -v exa)" ]; then exa --long --git --icons --color auto $@
  else git status $@
  fi
}