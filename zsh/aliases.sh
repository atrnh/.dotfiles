if [ "$(command -v nvim)" ]; then
	alias v='/usr/local/bin/nvim'
	alias vi='/usr/local/bin/nvim'
	alias vim='/usr/local/bin/nvim'
fi

if [ "$(command -v http)" ]; then
	alias http='http -v'
fi

if [ "$(command -v colordiff)" ]; then
	alias diff='colordiff'
fi

if [ "$(command -v kitty)" ]; then
	alias present="kitty @ set-font-size 16"
	alias s="kitty +kitten ssh"
fi

if [ "$(command -v pipenv)" ]; then
	alias pv='pipenv'
	alias pvr='pipenv run'
fi

alias gdiff="git difftool --no-symlinks --dir-diff"

if [ "$(command -v code-insiders)" ]; then
	alias ci='code-insiders'
fi

if [ "$(command -v exa)" ]; then
	unalias -m 'll'
	unalias -m 'l'
	unalias -m 'la'
	unalias -m 'ls'
	alias ls='exa -G --color auto --icons -a -s type'
	alias la='exa -G --color auto --icons -a -s type'
	alias l='exa -G--color auto --icons -a -s type'
	alias ll='exa -l --color always --icons -a -s type'
fi

# alias colors="kitty +kitten themes"

if [ "$(command -v rg)" ]; then
	unalias -m 'grep'
	alias grep='rg'
fi
