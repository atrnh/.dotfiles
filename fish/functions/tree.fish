function tree --wraps tree
    if command -q eza
        eza --tree --color always --icons $argv
    else
        command tree $argv
    end
end
