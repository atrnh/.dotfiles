asciinema_init() {
  source $LOCAL_BUNDLES/asciinema/aliases.zsh
}

if [ "$(command -v asciinema)" ]; then
  asciinema_init
fi