export BAT_THEME="Catppuccin-mocha"

# Now you can `cat` images!
cat() {
  if [[ $1 =~ .*\.(gif|jpeg|jpg|png) ]]; then
    wezterm imgcat $1
  else
    if [ "$(command -v bat)" ]; then bat $@
    else command cat $@
    fi
  fi
}