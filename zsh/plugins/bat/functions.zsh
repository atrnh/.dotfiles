# Now you can `cat` images!
cat() {
  if [[ $1 =~ .*\.(gif|jpeg|jpg|png) ]]; then
    wezterm imgcat $@
  else
    if [ "$(command -v bat)" ]; then bat $@
    else command cat $@
    fi
  fi
}