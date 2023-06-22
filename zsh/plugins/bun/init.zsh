export PATH="$BUN_INSTALL/bin:$PATH"
export BUN_INSTALL="$HOME/.bun"

# completions
[ -s "$BUN_INSTALL/_bun" ] && source "$BUN_INSTALL/_bun"
