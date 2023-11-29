colordiff_init() {
  source $LOCAL_BUNDLES/colordiff/aliases.zsh
}

if [ "$(command -v colordiff)" ]; then
  colordiff_init
fi