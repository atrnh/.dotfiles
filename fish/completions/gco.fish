complete -c gco -f -a '(git branch --sort=-committerdate --sort=-HEAD --format="%(refname:short)" 2>/dev/null)'
