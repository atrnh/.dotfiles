if [ "$(command -v asciinema)" ] && [ "$(command -v agg)" ]; then
  # Record asciinema and convert to gif
  rec() {
    asciinema rec $@
    echo "Converting to gif..."
    agg --font-family "FiraCode Nerd Font" $1 "$1.gif"
  }
fi