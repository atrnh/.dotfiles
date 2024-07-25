if [ "$(command -v eza)" ]; then
  alias ls="eza -G --color always --icons -a -s type"
  alias l="eza -G --color always --icons -a -s type"
  alias ll="eza --git -l --no-user --color always --icons -a -s type"

  tree() {
    eza --tree --color always --icons $@
  }
fi