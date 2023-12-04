if [ "$(command -v poetry)" ]; then
	export POETRY_CONFIG_DIR=$HOME/.config/pypoetry
  alias po="poetry"
  alias por="poetry run"
fi
