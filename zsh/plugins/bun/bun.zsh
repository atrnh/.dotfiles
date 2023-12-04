export BUN_INSTALL="$HOME/.bun"

[ -f $BUN_INSTALL ] && PATH="${PATH:+${PATH}:}$BUN_INSTALL/bin"
[ -s "$BUN_INSTALL/_bun" ] && source "$BUN_INSTALL/_bun"
