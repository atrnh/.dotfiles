if [ "$(command -v eza)" ]; then
  unalias ll
  unalias l
  unalias la
  unalias ls
  alias ls="eza -G --color always --icons -a -s type"
  alias la="eza -G --color always --icons -a -s type"
  alias l="eza -G --color always --icons -a -s type"
  alias ll="eza -l --color always --icons -a -s type"

  tree() {
    eza --tree --color always --icons $@
  }
fi

# git status
gs() {
  if [ "$(command -v eza)" ]; then eza --long --git --icons --color auto $@
  else git status $@
  fi
}
