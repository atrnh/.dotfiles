exa_init() {
  source $LOCAL_BUNDLES/exa/aliases.zsh
}

if [ "$(command -v exa)" ]; then
  exa_init
fi
