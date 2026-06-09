function igco
    if not command -q fzf
        echo 'igco: fzf is not installed' >&2
        return 127
    end

    set -l branch (git branch --all | fzf --reverse --prompt='git checkout: ' --header='Search for a branch' | string trim)
    if test -n "$branch"
        git checkout $branch
    end
end
