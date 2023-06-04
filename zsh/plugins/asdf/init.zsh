if [ "$(command -v asdf)" ]; then
  . /usr/local/opt/asdf/libexec/asdf.sh

  function penv {
    pipenv $@ --python $HOME/.asdf/shims/python
  }
fi
