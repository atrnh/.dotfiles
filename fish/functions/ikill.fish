function ikill
    if not command -q fzf
        echo 'ikill: fzf is not installed' >&2
        return 127
    end

    set -l line (lsof -i -n -P | fzf --reverse --pointer='> ' --prompt='Kill a process: ' --header='' --header-lines=1 | string replace -ra '\s+' ' ' | string trim)
    if test -z "$line"
        return
    end

    set -l fields (string split ' ' $line)
    set -l cmd $fields[1]
    set -l pid $fields[2]
    set -l name $fields[9]

    kill -9 $pid
    and echo "Killed $cmd at $name"
end
