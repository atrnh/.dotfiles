if [ "$(command -v asciinema)" ]; then
  # Interactively search for errant process with peco and kill it
  rec() {
    asciinema rec $@
  }
fi

if [ "$(command -v agg)" ]; then
  recg() {
    echo $1
    asciinema rec $@
    agg --font-family "FiraCode Nerd Font" $1 "$1.gif"
  }
fi