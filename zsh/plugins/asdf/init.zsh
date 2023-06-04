. /usr/local/opt/asdf/libexec/asdf.sh

function penv {
	pipenv $@ --python $HOME/.asdf/shims/python
}

export ASDF_PYTHON_DEFAULT_PACKAGES_FILE=$HOME/.config/asdf/.default-python-packages
