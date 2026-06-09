function rec
    if not command -q asciinema
        echo 'rec: asciinema is not installed' >&2
        return 127
    end

    asciinema rec $argv

    if test (count $argv) -gt 0; and command -q agg
        echo 'Converting to gif...'
        agg --font-family 'FiraCode Nerd Font' $argv[1] "$argv[1].gif"
    end
end
