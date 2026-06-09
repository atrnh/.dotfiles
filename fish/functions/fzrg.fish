function fzrg
    if not command -q rg
        echo 'fzrg: rg is not installed' >&2
        return 127
    end

    if not command -q fzf
        echo 'fzrg: fzf is not installed' >&2
        return 127
    end

    set -l rg_prefix 'rg --no-heading --color=always --smart-case'
    set -l query (string join ' ' $argv)

    fzf --disabled --query "$query" \
        --bind "start:reload:$rg_prefix {q}" \
        --bind "change:reload:sleep 0.1; $rg_prefix {q}; or true" \
        --delimiter : \
        --bind 'enter:become(echo {1})' \
        --layout=reverse
end
