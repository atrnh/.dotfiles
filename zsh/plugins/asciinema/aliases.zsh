if [ "$(command -v asciinema)" ]; then
  # Interactively search for errant process with peco and kill it
  rec() {
    asciinema rec $@
  }
fi