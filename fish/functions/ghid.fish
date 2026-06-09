function ghid
    if not command -q gh
        echo 'ghid: gh is not installed' >&2
        return 127
    end

    if not command -q fzf
        echo 'ghid: fzf is not installed' >&2
        return 127
    end

    set -l issue_num (_gh_issue_list | fzf --reverse --prompt='gh issue develop: ' --header='' --header-lines=1 --info=inline --height=40% | string replace -ra '\s+' ' ' | cut -d ' ' -f 1)
    if test -n "$issue_num"
        gh issue develop $issue_num --checkout
    end
end
