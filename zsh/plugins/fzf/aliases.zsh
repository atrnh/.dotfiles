if [ "$(command -v fzf)" ]; then
  # Interactively search for errant process with peco and kill it
  ikill() {
    local line=$(lsof -i -n -P | fzf --reverse --pointer='' --prompt='Kill a process  ' --header='' --header-lines=1 | tr -s ' ')
    local pid=$(echo $line | cut -d ' ' -f 2)
    local cmd=$(echo $line | cut -d ' ' -f 1)
    local name=$(echo $line | cut -d ' ' -f 9)

    kill -9 $pid && echo "Killed $cmd at $name"
  }

  # Search for branch and checkout
  igco() {
    git checkout $(git branch --all | fzf --reverse --prompt='git checkout  ' --header='Search for a branch')
  }
fi