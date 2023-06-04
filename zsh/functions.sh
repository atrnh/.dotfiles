# Interactively search for errant process with peco and kill it
ikill() {
	local line=$(lsof -i -n -P | peco | tr -s ' ')
	local pid=$(echo $line | cut -d ' ' -f 2)
	local cmd=$(echo $line | cut -d ' ' -f 1)
	local name=$(echo $line | cut -d ' ' -f 9)

	kill -9 $pid && echo "Killed $cmd at $name"
}

igco() {
	git checkout $(git branch | peco)
}

gh-search() {
	https --session=~/gh-authd.json -b api.github.com/search/repositories q==$1
}

connect_to_free_db() {
	psql --host=frodo-db-free.crkrlclc8wsy.us-west-1.rds.amazonaws.com
}

cat() {
	if [[ $1 =~ .*\.(gif|jpeg|jpg|png) ]]; then
		wezterm imgcat $@
	else
		bat $@
	fi
}

obsidian() {
	cd $HOME/work/Notes/Work
	nvim
}
