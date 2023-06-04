export POETRY_CONFIG_DIR=$HOME/.config/pypoetry

function poetry {
	if [ ! -f ./.tool-versions ] && [ -f ./pyproject.toml ]; then
		asdf local python $(asdf current python | tr -s ' ' | cut -d ' ' -f 2)
	fi

	$HOME/.local/bin/poetry $@
}
