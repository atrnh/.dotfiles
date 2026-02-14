#
# A bunch of work-related utils.
#

mkcode() {
  local target="$1"
  if [ -z "$1" ]; then
    target=$PWD
  fi
  mkdir -p $target/starter/$(basename $target)
  mkdir -p $target/solution/$(basename $target)
  echo "Successfully created:"
  tree -L3 $target
}

mkdemo() {
  local target="$1"
  if [ -z "$1" ]; then
    target=$PWD
  fi
  mkdir $target/$(basename $target)-demo
  echo "Successfully created:"
  tree -L3 $target
}