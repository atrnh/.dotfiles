# append local bin to path
if [[ ! "$PATH" == *$HOME/.local/bin:* ]]; then
  PATH="${PATH:+${PATH}:}$HOME/.local/bin"
fi