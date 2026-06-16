function current_dir
    basename "$PWD"
end

if command -q colordiff
    abbr -a diff colordiff
end

if command -q eza
    abbr -a ls eza -G --color always --icons -a -s type
    abbr -a l eza -G --color always --icons -a -s type
    abbr -a ll eza --git -l --no-user --color always --icons -a -s type
end

if command -q http
    abbr -a httpv http -v
end

if command -q macchina
    abbr -a neofetch 'macchina --theme Ashley'
end

if command -q nvim
    abbr -a v nvim
    abbr -a vi nvim
    abbr -a vim nvim
end

if command -q rg
    abbr -a ag rg
    abbr -a grep rg
end

if command -q code-insiders
    abbr -a code code-insiders
end

abbr -a ghid --function interactive_gh_issue_develop

# Git
abbr -a g git
abbr -a gsb git status -sb
abbr -a gS git status --long
abbr -a gco git checkout
abbr -a gcob git checkout -b
abbr -a gb git branch
abbr -a gc git commit
abbr -a gcam git commit -am
abbr -a ga git add
abbr -a gm git merge