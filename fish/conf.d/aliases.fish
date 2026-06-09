function current_dir
    basename "$PWD"
end

if command -q colordiff
    alias diff='colordiff'
end

if command -q eza
    alias ls='eza -G --color always --icons -a -s type'
    alias l='eza -G --color always --icons -a -s type'
    alias ll='eza --git -l --no-user --color always --icons -a -s type'
end

if command -q http
    alias httpv='http -v'
end

if command -q macchina
    alias neofetch='macchina --theme Ashley'
end

if command -q nvim
    alias v='nvim'
    alias vi='nvim'
    alias vim='nvim'
end

if command -q poetry
    alias po='poetry'
    alias por='poetry run'
end

if command -q rg
    alias ag='rg'
    alias grep='rg'
end

if command -q code-insiders
    alias code='code-insiders'
end
