if [ "$(command -v exa)" ]; then
  # tree replacement
  tree() {
    exa -tree $@
  }

  # git status
  gs() {
    exa --long --git
  }

  unalias -m 'll'
  unalias -m 'l'
  unalias -m 'la'
  unalias -m 'ls'
  alias ls='exa -G --color auto --icons -a -s type'
  alias la='exa -G --color auto --icons -a -s type'
  alias l='exa -G--color auto --icons -a -s type'
  alias ll='exa -l --color always --icons -a -s type'
fi
