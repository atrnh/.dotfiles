# Interactively search for errant process with peco and kill it
function ikill {
  local line=$(lsof -i -n -P | peco | tr -s ' ')
  local pid=$(echo $line | cut -d ' ' -f 2)
  local cmd=$(echo $line | cut -d ' ' -f 1)
  local name=$(echo $line | cut -d ' ' -f 9)

  kill -9 $pid && echo "Killed $cmd at $name"
}

function igco {
  git checkout $(git branch | peco)
}

# output advising notes as markdown, redir to clipboard
# takes in 1 arg which is tag name (student's name)
# function hbadvise {
#   jrnl "@$1" -from today --export markdown | python3 -m markdown | pbcopy
# }

# function slackqa {
#   kitty @ new-window --title "presenter" --new-tab --tab-title "slackterm"
#   kitty @ detach-tab -m title:slackterm
#   kitty @ set-colors -m title:presenter ~/.dotfiles/lightkitty.conf
#   kitty @ set-background-opacity -m title:presenter 0.6
# }
#
# function hbgrade {
#   git config user.name "Hackbright Grader"
#   git config user.email "education@hackbrightacademy.com"
#   git checkout -b feedback
# }

function gh-search {
  https --session=~/gh-authd.json -b api.github.com/search/repositories q==$1
}

function cohort {
  export INVOKE_COHORT=$1
}

function connect_to_free_db {
  psql --host=frodo-db-free.crkrlclc8wsy.us-west-1.rds.amazonaws.com
}

cat () {
  if [[ $1 =~ .*\.(gif|jpeg|jpg|png) ]]
  then
    kitty +kitten icat $1
  else
    bat --theme='Sublime Snazzy' $1
  fi
}

multised () {
	cat $2 |
		tr '\n' '\r' |
		sed -e $1  |
		tr '\r' '\n'
}
